import 'package:flutter/material.dart';
import '../models/cart_model.dart';
import '../services/cart_service.dart';

class CartProvider with ChangeNotifier {
  Cart _cart = Cart(items: []);
  bool _isLoading = false;
  String? _error;
  
  Cart get cart => _cart;
  bool get isLoading => _isLoading;
  String? get error => _error;
  int get itemCount => _cart.totalItems;
  double get total => _cart.total;
  
  // Load cart
  Future<void> loadCart() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      _cart = await CartService.getCart();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
  
  // Add to cart
  Future<bool> addToCart(int productId, int quantity) async {
    _error = null;
    
    try {
      await CartService.addToCart(productId, quantity);
      await loadCart(); // Reload cart
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }
  
  // Update quantity
  Future<bool> updateQuantity(int itemId, int quantity) async {
    _error = null;
    
    try {
      if (quantity <= 0) {
        await removeFromCart(itemId);
      } else {
        await CartService.updateCartItem(itemId, quantity);
        await loadCart();
      }
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }
  
  // Remove from cart
  Future<bool> removeFromCart(int itemId) async {
    _error = null;
    
    try {
      await CartService.removeFromCart(itemId);
      await loadCart();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }
  
  // Clear cart
  Future<bool> clearCart() async {
    _error = null;
    
    try {
      await CartService.clearCart();
      _cart = Cart(items: []);
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }
  
  // Checkout
  Future<Map<String, dynamic>?> checkout({
    required String paymentMethod,
    String? shippingAddress,
  }) async {
    _error = null;
    _isLoading = true;
    notifyListeners();
    
    try {
      final result = await CartService.checkout(
        paymentMethod: paymentMethod,
        shippingAddress: shippingAddress,
      );
      
      // Clear cart after successful checkout
      _cart = Cart(items: []);
      _isLoading = false;
      notifyListeners();
      
      return result;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return null;
    }
  }
  
  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
