import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/src/providers/product.provider.dart';

class CartItem {
  final String id;
  final Product product;
  int quantity;

  CartItem({
    @required this.id,
    @required this.product,
    this.quantity = 1,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};
  double total = 0;

  Map<String, CartItem> get items => {..._items};

  void addItem(Product prod) {
    if (_items.containsKey(prod.id)) {
      _items[prod.id].quantity++;
    } else {
      _items.putIfAbsent(
        prod.id,
        () => CartItem(
          id: DateTime.now().toString(),
          product: prod,
        ),
      );
    }
    total += prod.price;
    notifyListeners();
  }

  void deleteItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    final item = _items[productId];
    total -= (item.product.price * item.quantity);
    _items.remove(productId);
    notifyListeners();
  }

  void deleteSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    final item = _items[productId];
    total -= item.product.price;
    if (item.quantity == 1) {
      _items.remove(productId);
    } else {
      _items[productId].quantity--;
    }
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
