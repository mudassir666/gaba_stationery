import 'package:flutter/material.dart';

class CartBlueprint {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartBlueprint({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartBlueprint> _items = {};

  Map<String, CartBlueprint> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(String productId, String title, double price) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existItem) => CartBlueprint(
          id: existItem.id,
          title: existItem.title,
          quantity: existItem.quantity + 1,
          price: existItem.price,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartBlueprint(
          id: DateTime.now().toString(),
          title: title,
          quantity: 1,
          price: price,
        ),
      );
    }

    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if(_items[productId]!.quantity > 1) {
      _items.update(
        productId,
        (existItem) => CartBlueprint(
          id: existItem.id,
          title: existItem.title,
          quantity: existItem.quantity - 1,
          price: existItem.price,
        ),
      );
     }
       else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }
}
