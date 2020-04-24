import 'dart:io';
import 'package:flutter/foundation.dart';

class PlaceLocation {
  final String lat;
  final String lon;
  final String location;

  PlaceLocation({this.location,  @required this.lat,  @required this.lon});
}

class Place {
  final String id;
  final String title;
  final PlaceLocation location;
  final File image;

  Place({ @required this.id,  @required this.title,  @required this.location,  @required this.image,});

}