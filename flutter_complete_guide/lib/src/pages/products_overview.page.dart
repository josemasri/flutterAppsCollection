import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/src/providers/cart.provider.dart';
import 'package:flutter_complete_guide/src/providers/product.provider.dart';
import 'package:flutter_complete_guide/src/providers/products.provider.dart';
import 'package:flutter_complete_guide/src/widgets/app_drawer.widget.dart';
import 'package:flutter_complete_guide/src/widgets/products_grid.widget.dart';
import 'package:provider/provider.dart';

enum FilterOptions { Favorites, All }

class ProductsOverviewPage extends StatefulWidget {
  final List<Product> products;
  const ProductsOverviewPage(this.products);

  @override
  _ProductsOverviewPageState createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  bool _showFavoritesOnly = false;
  bool loaded = false;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    Provider.of<Products>(context).items = widget.products;
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: <Widget>[
          Consumer<Cart>(
            builder: (context, cart, child) => Badge(
              position: BadgePosition.topRight(right: 1, top: 1),
              badgeContent: Text(cart.items.length.toString()),
              child: child,
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () => Navigator.pushNamed(
                context,
                'cart',
              ),
            ),
          ),
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            onSelected: (selected) {
              setState(() {
                if (selected == FilterOptions.Favorites) {
                  _showFavoritesOnly = true;
                } else {
                  _showFavoritesOnly = false;
                }
              });
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show all'),
                value: FilterOptions.All,
              ),
            ],
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : ProductsGrid(_showFavoritesOnly),
    );
  }
}
