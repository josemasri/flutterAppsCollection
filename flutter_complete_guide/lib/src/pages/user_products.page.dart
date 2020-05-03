import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/src/providers/products.provider.dart';
import 'package:flutter_complete_guide/src/widgets/app_drawer.widget.dart';
import 'package:flutter_complete_guide/src/widgets/user_product_item.widget.dart';
import 'package:provider/provider.dart';

class UserProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed('edit-product');
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: products.items.length,
          itemBuilder: (context, i) {
            return UserProductItem(products.items[i]);
          },
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
