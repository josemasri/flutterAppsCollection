import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/src/providers/cart.provider.dart';
import 'package:provider/provider.dart';

class CartCard extends StatelessWidget {
  final String id;
  final CartItem cartItem;

  const CartCard({
    @required this.id,
    @required this.cartItem,
  });

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    return Dismissible(
      direction: DismissDirection.endToStart,
      background: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        color: Colors.red,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
      ),
      key: Key(id),
      onDismissed: (direction) => cart.deleteItem(id),
      confirmDismiss: (direction) => _asyncConfirmDialog(context),
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: FadeInImage(
              width: 75,
              height: 50,
              fit: BoxFit.fill,
              placeholder: AssetImage('assets/loading.gif'),
              image: NetworkImage(cartItem.product.imageUrl),
            ),
            title: Text(cartItem.product.title),
            subtitle: Text(
                '${cartItem.quantity} x Total \$${cartItem.quantity * cartItem.product.price}'),
            trailing: CircleAvatar(
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: FittedBox(
                  child: Text('\$${cartItem.product.price}'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _asyncConfirmDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure?'),
          content: Text('This will remove the item from your cart.'),
          actions: <Widget>[
            FlatButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            FlatButton(
              child: Text('ACCEPT'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            )
          ],
        );
      },
    );
  }
}
