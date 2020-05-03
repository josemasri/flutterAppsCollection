import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_complete_guide/src/providers/cart.provider.dart';
import 'package:flutter_complete_guide/src/providers/product.provider.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, 'product-details',
          arguments: product.id),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          child: FadeInImage(
            fit: BoxFit.fill,
            placeholder: AssetImage('assets/loading.gif'),
            image: NetworkImage(
              product.imageUrl,
            ),
          ),
          header: Container(
            child: Text(
              product.price.toStringAsFixed(2),
            ),
          ),
          footer: GridTileBar(
            leading: Consumer<Product>(
              builder: (context, product, child) => IconButton(
                icon: Icon(product.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border),
                onPressed: () => product.toggleFavorite(),
                color: Theme.of(context).accentColor,
              ),
            ),
            backgroundColor: Colors.black87,
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                cart.addItem(product);
                Scaffold.of(context).hideCurrentSnackBar();
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    duration: Duration(seconds: 2),
                    content: Text(
                      'Item added to cart',
                    ),
                    action: SnackBarAction(label: 'Undo', onPressed: () {
                      cart.deleteSingleItem(product.id);
                    }),
                  ),
                );
              },
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
      ),
    );
  }
}
