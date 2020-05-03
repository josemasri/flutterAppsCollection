import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/src/providers/product.provider.dart';
import 'package:flutter_complete_guide/src/providers/products.provider.dart';
import 'package:provider/provider.dart';

class UserProductItem extends StatelessWidget {
  final Product product;

  const UserProductItem(this.product);

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(product.title),
          subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(product.imageUrl),
          ),
          trailing: Container(
            width: 100,
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed('edit-product', arguments: product);
                  },
                  color: Theme.of(context).primaryColor,
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    final option = await _ackAlert(context);
                    if (option) {
                      await products.deleteProduct(product.id);
                    }
                  },
                  color: Theme.of(context).errorColor,
                ),
              ],
            ),
          ),
        ),
        Divider(),
      ],
    );
  }

  Future<bool> _ackAlert(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure?'),
          content: const Text(
            'Product will be deleted',
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            FlatButton(
              child: Text('Confirm'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }
}
