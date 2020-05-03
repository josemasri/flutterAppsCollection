import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/src/providers/cart.provider.dart';

class Order {
  final String id;
  final List<CartItem> products;
  final double amount;
  final DateTime dateTime;

  Order({
    @required this.products,
    @required this.amount,
  })  : id = DateTime.now().toString(),
        dateTime = DateTime.now();

  // Order(double amount, List<CartItem> products ) {
  //   this.id = DateTime.now().toString();
  // }
}

class Orders with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders => [..._orders];
  addOrder(Order order) {
    _orders.insert(0, order);
    notifyListeners();
  }
}
