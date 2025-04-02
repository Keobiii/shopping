import 'package:shopping/data/models/Product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartProvider extends ChangeNotifier {
  final List<Product> _cart = [];
  List<Product> get cart => _cart;

  void toggleFavorite(Product product) {
    // if (_cart.contains(product)) {
    //   // _cart.remove(product);
    // } else {
    //   _cart.add(product);
    // }

    if (_cart.contains(product)) {
      for (Product element in _cart) {
        element.quantity++;
      }
    } else {
      _cart.add(product);
    }

    notifyListeners();
  }

  incrementQuantity(int index) => _cart[index].quantity++;
  // decrementQuantity(int index) => _cart[index].quantity--;

  void decrementQuantity(int index) {
    if (_cart[index].quantity <= 1) {
      _cart.removeAt(index);
    } else {
      _cart[index].quantity--;
    }
    notifyListeners(); 
  }
  getTotalPrice() {
    double total = 0.0;
    for (Product element in _cart) {
      total += element.price * element.quantity;
    }

    return total;
  }

  bool isExist(Product product) {
    final isExist = _cart.contains(product);
    return isExist;
  }

  static CartProvider of(
    BuildContext context, {
      bool listen = true,
  }) {
    return Provider.of<CartProvider>(
      context,
      listen: listen
    );
  }
}