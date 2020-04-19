import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/produtDetailScreen.dart';
import './screens/productsOverviewScreen.dart';
import './providers/products.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
          value: Products(),
          child: MaterialApp(
        title: "Shop",
        theme: ThemeData(primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: "Lato"
        ),
        home: productOverViewScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx)=>ProductDetailScreen()
        },
      ),
    );
  }
}
