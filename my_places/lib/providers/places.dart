import 'package:flutter/material.dart';
import 'dart:io';
import '../models/place.dart';
import '../helpers/dbHelper.dart';

class Places with ChangeNotifier {
  final placeTable = "user_places";
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
    DBHelper.insert(placeTable, {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData(placeTable);
    _items = dataList
        .map(
          (item) =>
              Place(id: item['id'], title: item['title'], image: File(item['image']), location: null),
        )
        .toList();
        notifyListeners();
  }
}
