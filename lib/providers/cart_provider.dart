import 'package:e_commerce_app/models/cart_item_model.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = []; // Use a List to store cart items

  List<CartItem> get items => [..._items]; // Return a copy of the list

  int get itemCount => _items.length; // Total unique items in the cart

  double get totalAmount {
    return _items.fold(
      0.0,
      (sum, item) => sum + (item.price * item.quantity),
    );
  }

  void addItem(String productId, String imageUrl, String title, double price) {
    // Check if the item already exists in the cart
    final existingIndex =
        _items.indexWhere((item) => item.productId == productId);

    if (existingIndex >= 0) {
      // Update the quantity of the existing item
      _items[existingIndex] = CartItem(
        productId: _items[existingIndex].productId,
        imageUrl: _items[existingIndex].imageUrl,
        title: _items[existingIndex].title,
        quantity: _items[existingIndex].quantity + 1,
        price: _items[existingIndex].price,
      );
    } else {
      // Add a new item to the cart
      _items.add(
        CartItem(
          productId: productId,
          imageUrl: imageUrl,
          title: title,
          quantity: 1,
          price: price,
        ),
      );
    }
    notifyListeners();
  }

  void decreaseItem(String productId) {
    // Find the item in the cart
    final existingIndex =
        _items.indexWhere((item) => item.productId == productId);

    if (existingIndex >= 0) {
      if (_items[existingIndex].quantity > 1) {
        // Decrease the quantity by 1
        _items[existingIndex] = CartItem(
          productId: _items[existingIndex].productId,
          imageUrl: _items[existingIndex].imageUrl,
          title: _items[existingIndex].title,
          quantity: _items[existingIndex].quantity - 1,
          price: _items[existingIndex].price,
        );
      } else {
        // Remove the item if the quantity is 1
        _items.removeAt(existingIndex);
      }
      notifyListeners();
    }
  }

  void removeItem(String productId) {
    // Remove the item by filtering the list
    _items.removeWhere((item) => item.productId == productId);
    notifyListeners();
  }

  void clearCart() {
    _items.clear(); // Clear the entire cart
    notifyListeners();
  }
}
