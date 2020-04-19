import 'package:flutter/material.dart';
import 'package:shop_app/screens/produtDetailScreen.dart';
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
      routes: {
        ProductDetailScreen.routeName: (ctx)=>ProductDetailScreen()
      },
    );
  }
}
