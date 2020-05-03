import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/src/providers/products.provider.dart';
import 'package:flutter_complete_guide/src/widgets/product_item.widget.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  final bool _showOnlyFavorites;

  const ProductsGrid(this._showOnlyFavorites);
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products =
        _showOnlyFavorites ? productsData.favItems : productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (context, i) => ChangeNotifierProvider.value(
        child: ProductItem(),
        value: products[i],
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
