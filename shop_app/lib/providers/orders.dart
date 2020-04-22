import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import './cart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({this.id, this.amount, this.dateTime, this.products});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    const url = "https://shop-flutter-fec3d.firebaseio.com/orders.json";
    final timeStamp = DateTime.now();
    final response = await http.post(url, body: json.encode({
      'amount': total,
      'dateTime': timeStamp.toIso8601String(),
      'products': [
        cartProducts.map((cp) => {
          'id': cp.id,
          'title': cp.title,
          'quantity': cp.quantity,
          'price': cp.price,
        }).toList(),
      ]
    }));
    _orders.insert(
      0,
      OrderItem(
          id: json.decode(response.body)['name'],
          amount: total,
          dateTime: timeStamp,
          products: cartProducts),
    );
    notifyListeners();
  }
}
