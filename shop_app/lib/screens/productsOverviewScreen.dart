import 'package:flutter/material.dart';
import '../widgets/productGrid.dart';


enum FilterOptions {
  Favorites, 
  All
}
 
class productOverViewScreen extends StatefulWidget {


  @override
  _productOverViewScreenState createState() => _productOverViewScreenState();
}

class _productOverViewScreenState extends State<productOverViewScreen> {

  var _showOnlyFavorites = false;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(title: Text("Shop"),
        actions: <Widget>[
         PopupMenuButton(
           onSelected: (FilterOptions selectedValue) {
            print(selectedValue);
            setState(() {
              _showOnlyFavorites = selectedValue == FilterOptions.Favorites;              
            });
           },
           itemBuilder: (_)=>[ 
           PopupMenuItem(child: Text("Only Favorites"), value:FilterOptions.Favorites),
           PopupMenuItem(child: Text("Show All"), value:FilterOptions.All),
         ], icon: Icon(Icons.more_vert)) ,
        ],),
        body: ProductsGrid(_showOnlyFavorites)
        );
  }
}

