import 'package:flutter/material.dart';
import 'dart:io';
import '../models/place.dart';
import '../helpers/dbHelper.dart';

class Places with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String title, File pickedImage) {
    final newPlace = Place(
        id: DateTime.now().toString(),
        image: pickedImage,
        title: title,
        location: null);
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
    });
  }
}
