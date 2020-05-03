import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/src/providers/orders.provider.dart';
import 'package:flutter_complete_guide/src/widgets/cart_card.widget.dart';
import 'package:provider/provider.dart';

import 'package:flutter_complete_guide/src/providers/cart.provider.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final orders = Provider.of<Orders>(context, listen: false);
    final cartItems = cart.items;

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Container(
        child: cartItems.length > 0
            ? Column(
                children: <Widget>[
                  _buildTotalCard(cart, context, orders, cartItems),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, i) {
                        final entry = cartItems.entries.toList()[i];
                        return CartCard(
                          cartItem: entry.value,
                          id: entry.key,
                        );
                      },
                    ),
                  )
                ],
              )
            : Center(
                child: Text('Add elements to cart'),
              ),
      ),
    );
  }

  Card _buildTotalCard(
    Cart cart,
    BuildContext context,
    Orders orders,
    Map<String, CartItem> cartItems,
  ) {
    return Card(
      margin: EdgeInsets.all(15),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Total',
              style: TextStyle(fontSize: 20),
            ),
            Spacer(),
            Chip(
              label: Text(
                '\$${cart.total.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            SizedBox(
              width: 10,
            ),
            FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(18.0),
                side: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 5,
                ),
              ),
              color: Colors.white,
              onPressed: () {
                orders.addOrder(
                  Order(
                    products: cartItems.values.toList(),
                    amount: cart.total,
                  ),
                );
                cart.clear();
                Navigator.pushReplacementNamed(context, 'orders');
                _ackAlert(context);
              },
              child: Text(
                'ORDER NOW',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _ackAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Order created'),
          content: const Text(
            'An order has been created',
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
