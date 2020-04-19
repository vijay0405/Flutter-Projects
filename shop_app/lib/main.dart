import 'package:flutter/material.dart';
import './screens/productsOverviewScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Shop",
      theme: ThemeData(primarySwatch: Colors.purple,
        accentColor: Colors.deepOrange,
        fontFamily: "Lato"
      ),

      home: productOverViewScreen(),
    );
  }
}
