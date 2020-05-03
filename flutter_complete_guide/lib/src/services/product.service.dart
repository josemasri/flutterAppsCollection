import 'dart:convert';

import 'package:flutter_complete_guide/src/providers/product.provider.dart';
import 'package:http/http.dart' as http;

class ProductService {
  static final String url = 'https://flutter-max-shop-269c9.firebaseio.com';

  static addProduct(Product product) async {
    return await http.post('$url/products.json',
        body: jsonEncode({
          'title': product.title,
          'price': product.price,
          'description': product.description,
          'imageUrl': product.imageUrl
        }));
  }

  static updateProduct(Product product) async {
    return await http.put(
      '$url/products/${product.id}.json',
      body: jsonEncode({
        'title': product.title,
        'price': product.price,
        'description': product.description,
        'imageUrl': product.imageUrl
      }),
    );
  }

  static Future<List<Product>> getProducts() async {
    final res = await http.get('$url/products.json');
    final productsData = json.decode(res.body);
    final List<Product> products = [];
    productsData.forEach((final String key, final product) {
      products.add(Product(
        id: key,
        title: product['title'],
        description: product['description'],
        price: product['price'],
        imageUrl: product['imageUrl'],
      ));
    });
    return products;
  }

  static Future<void> deleteProduct(String id) async {
    await http.delete('$url/products/$id.json');
  }
}
