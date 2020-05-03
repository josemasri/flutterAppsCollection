import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/src/pages/cart.page.dart';
import 'package:flutter_complete_guide/src/pages/edit_product.page.dart';
import 'package:flutter_complete_guide/src/pages/orders.page.dart';
import 'package:flutter_complete_guide/src/pages/product_details.page.dart';
import 'package:flutter_complete_guide/src/pages/products_overview.page.dart';
import 'package:flutter_complete_guide/src/pages/user_products.page.dart';
import 'package:flutter_complete_guide/src/providers/cart.provider.dart';
import 'package:flutter_complete_guide/src/providers/orders.provider.dart';
import 'package:flutter_complete_guide/src/providers/product.provider.dart';
import 'package:flutter_complete_guide/src/providers/products.provider.dart';
import 'package:flutter_complete_guide/src/services/product.service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final List<Product> products = await ProductService.getProducts();
  runApp(MyApp(products));
}

class MyApp extends StatelessWidget {
  final List<Product> products;
  const MyApp(this.products);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Products()),
        ChangeNotifierProvider.value(value: Cart()),
        ChangeNotifierProvider.value(value: Orders()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyShop',
        theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato'),
        initialRoute: 'product-overview',
        routes: {
          'product-overview': (context) => ProductsOverviewPage(products),
          'product-details': (context) => ProductDetailPage(),
          'cart': (context) => CartPage(),
          'orders': (context) => OrdersPage(),
          'user-products': (context) => UserProductsPage(),
          'edit-product': (context) => EditProductPage(),
        },
      ),
    );
  }
}
