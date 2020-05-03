import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/src/providers/product.provider.dart';
import 'package:flutter_complete_guide/src/services/product.service.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items {  
    return [..._items];
  }

  set items(List<Product> products) {
    _items = products;
    // notifyListeners();
  }

  List<Product> get favItems =>
      items.where((product) => product.isFavorite).toList();

  Product findById(String id) {
    return items.firstWhere((product) => product.id == id);
  }

  void addProduct(Product product) async {
    Product newProduct;
    if (product.id != null) {
      for (var i = 0; i < _items.length; i++) {
        if (product.id == _items[i].id) {
          _items[i] = Product(
            id: product.id,
            title: product.title,
            description: product.description,
            price: product.price,
            imageUrl: product.imageUrl,
            isFavorite: product.isFavorite,
          );
          _items[i].isFavorite = product.isFavorite;
        }
      }
      await ProductService.updateProduct(product);
    } else {
      newProduct = Product(
        id: DateTime.now().toString(),
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );
      _items.add(newProduct);
      await ProductService.addProduct(product);
    }
    notifyListeners();
  }

  Future<void> deleteProduct(String id) async {
    _items.removeWhere((product) => product.id == id);
    await ProductService.deleteProduct(id);
    notifyListeners();
  }
}
