import '../core/config/api_config.dart';
import '../models/cart_model.dart';
import 'api_service.dart';

class CartService {
  // Get cart
  static Future<Cart> getCart() async {
    try {
      final response = await ApiService.get(ApiConfig.cart);
      
      // La respuesta puede ser directamente el carrito o estar en 'results'
      final cartData = response is List 
          ? {'items': response}
          : response;
      
      return Cart.fromJson(cartData);
    } catch (e) {
      rethrow;
    }
  }
  
  // Add item to cart
  static Future<CartItem> addToCart(int productId, int quantity) async {
    try {
      final response = await ApiService.post(
        ApiConfig.cart,
        {
          'product': productId,
          'quantity': quantity,
        },
      );
      
      return CartItem.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
  
  // Update cart item
  static Future<CartItem> updateCartItem(int itemId, int quantity) async {
    try {
      final response = await ApiService.put(
        '${ApiConfig.cart}$itemId/',
        {'quantity': quantity},
      );
      
      return CartItem.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
  
  // Remove item from cart
  static Future<void> removeFromCart(int itemId) async {
    try {
      await ApiService.delete('${ApiConfig.cart}$itemId/');
    } catch (e) {
      rethrow;
    }
  }
  
  // Clear cart
  static Future<void> clearCart() async {
    try {
      final cart = await getCart();
      for (var item in cart.items) {
        if (item.id != null) {
          await removeFromCart(item.id!);
        }
      }
    } catch (e) {
      rethrow;
    }
  }
  
  // Checkout
  static Future<Map<String, dynamic>> checkout({
    required String paymentMethod,
    String? shippingAddress,
  }) async {
    try {
      final response = await ApiService.post(
        ApiConfig.checkout,
        {
          'payment_method': paymentMethod,
          if (shippingAddress != null) 'shipping_address': shippingAddress,
        },
      );
      
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
