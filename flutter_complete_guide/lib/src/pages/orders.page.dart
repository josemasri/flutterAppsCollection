import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/src/providers/orders.provider.dart';
import 'package:flutter_complete_guide/src/widgets/app_drawer.widget.dart';
import 'package:flutter_complete_guide/src/widgets/order_card.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your orders',
        ),
      ),
      body: ListView.builder(
        itemCount: ordersData.orders.length,
        itemBuilder: (context, i) {
          return OrderCard(ordersData.orders[i]);
        },
      ),
      drawer: AppDrawer(),
    );
  }
}
