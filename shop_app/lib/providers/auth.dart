import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../models/httpExceptions.dart';
import 'dart:convert';

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
      final url =
          "https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyBUtRwN0SaNzXHlvqXVbzI9eQQ09y6Piwk";
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

  void logout() {
    _token = null;
    _userId = null;
    _expiryTime = null;
    if(_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
  }

  void _autoLogout() {
    if(_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpiry = _expiryTime.difference(DateTime.now()).inSeconds;
    _authTimer =  Timer(Duration(seconds: timeToExpiry), logout);
  }


}
