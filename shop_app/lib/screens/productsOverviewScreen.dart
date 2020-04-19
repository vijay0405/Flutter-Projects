import 'package:flutter/material.dart';
import '../widgets/productGrid.dart';
 
class productOverViewScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Shop")),
        body: ProductsGrid()
        );
  }
}

