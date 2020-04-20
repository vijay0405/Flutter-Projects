import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/appDrawer.dart';
import '../providers/orders.dart' show Orders;
import '../widgets/orderItem.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Your Orders"),
        ),
        drawer: AppDrawer(),
        body: ListView.builder(
          itemCount: orderData.orders.length,
          itemBuilder: (ctx, i){
            return OrderItem(orderData.orders[i]);
          },
        ));
  }
}
