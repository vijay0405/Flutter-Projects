import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/httpExceptions.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;



class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryTime;
  String _userId;
  Timer _authTimer;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryTime != null &&
        _expiryTime.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String get userId {
    return _userId;
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    try {
      String data = await rootBundle.loadString('secrets.json');
      Map<String, dynamic> jsonResult = json.decode(data) as Map<String, dynamic>;
      print(jsonResult);
      String api_key = jsonResult['api_key'];
      final url = 
          "https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=$api_key";
      final response = await http.post(
        url,
        body: json.encode(
          {'email': email, 'password': password, 'returnSecureToken': true},
        ),
      );

      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryTime = DateTime.now().add(
        Duration(
          seconds: int.parse(responseData['expiresIn']),
        ),
      );
      _autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'expriyTime': _expiryTime.toIso8601String()
      });
      prefs.setString('userData', userData);
      print(json.decode(response.body));
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, "signUp");
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, "signInWithPassword");
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if(!prefs.containsKey("userData")) {
      return false;
    }
    final extractedUserData = json.decode(prefs.getString("userData")) as Map<String, Object>;
    final expiryTime = DateTime.parse(extractedUserData['expriyTime']);

    if(expiryTime.isBefore(DateTime.now())) {
      return false;
    }

    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _expiryTime = expiryTime;
    notifyListeners();
    _autoLogout();
    return true;
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _expiryTime = null;
    if(_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void _autoLogout() {
    if(_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpiry = _expiryTime.difference(DateTime.now()).inSeconds;
    _authTimer =  Timer(Duration(seconds: timeToExpiry), logout);
  }


}
