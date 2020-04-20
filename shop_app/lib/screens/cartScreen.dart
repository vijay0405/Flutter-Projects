import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart' show Cart;
import '../providers/orders.dart';
import '../widgets/cartItem.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Your Cart")),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Total', style: TextStyle(fontSize: 20)),
                    Spacer(),
                    SizedBox(
                      width: 10,
                    ),
                    Chip(
                      label: Text('\$${cart.totalAmount.toStringAsFixed(2)}',
                          style: TextStyle(
                            color:
                                Theme.of(context).primaryTextTheme.title.color,
                          )),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    FlatButton(
                      onPressed: () {
                        Provider.of<Orders>(context, listen: false).addOrder(
                            cart.items.values.toList(), cart.totalAmount);
                        cart.clearCart();
                      },
                      child: Text('Order Now'),
                      textColor: Theme.of(context).primaryColor,
                    )
                  ],
                ),
                padding: EdgeInsets.all(18)),
          ),
          SizedBox(height: 10),
          Expanded(
              child: ListView.builder(
                  itemBuilder: (ctx, i) => CartItem(
                      cart.items.values.toList()[i].id,
                      cart.items.keys.toList()[i],
                      cart.items.values.toList()[i].title,
                      cart.items.values.toList()[i].quantity,
                      cart.items.values.toList()[i].price),
                  itemCount: cart.itemCount))
        ],
      ),
    );
  }
}
