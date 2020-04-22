import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../widgets/appDrawer.dart';
import '../widgets/productGrid.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import './cartScreen.dart';

enum FilterOptions { Favorites, All }

class productOverViewScreen extends StatefulWidget {
  @override
  _productOverViewScreenState createState() => _productOverViewScreenState();
}

class _productOverViewScreenState extends State<productOverViewScreen> {
  var _showOnlyFavorites = false;

  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchAndSetData().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // final cart = Provider.of<Cart>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Shop"),
          actions: <Widget>[
            PopupMenuButton(
                onSelected: (FilterOptions selectedValue) {
                  print(selectedValue);
                  setState(() {
                    _showOnlyFavorites =
                        selectedValue == FilterOptions.Favorites;
                  });
                },
                itemBuilder: (_) => [
                      PopupMenuItem(
                          child: Text("Only Favorites"),
                          value: FilterOptions.Favorites),
                      PopupMenuItem(
                          child: Text("Show All"), value: FilterOptions.All),
                    ],
                icon: Icon(Icons.more_vert)),
            Consumer<Cart>(
              builder: (_, cart, ch) =>
                  Badge(child: ch, value: cart.itemCount.toString()),
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
              ),
            )
          ],
        ),
        drawer: AppDrawer(),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ProductsGrid(_showOnlyFavorites));
  }
}
