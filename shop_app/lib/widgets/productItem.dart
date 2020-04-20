import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/produtDetailScreen.dart';
import '../providers/product.dart';
import '../providers/cart.dart';

class productItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // productItem(this.id, this.title, this.imageUrl);

  productItem();

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                arguments: product.id);
          },
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black38,
          leading: Consumer<Product>(
              builder: (ctx, Product, child) => IconButton(
                    icon: Icon(product.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border),
                    onPressed: () {
                      product.toggleFavStatus();
                    },
                    color: Theme.of(context).accentColor,
                  )),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              cart.addItem(product.id, product.title, product.price);
            },
            color: Theme.of(context).accentColor,
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}