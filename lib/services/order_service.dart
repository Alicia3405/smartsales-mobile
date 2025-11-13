import '../core/config/api_config.dart';
import '../models/order.dart';
import 'api_service.dart';

class OrderService {
  // Get user orders
  static Future<List<Order>> getOrders() async {
    try {
      final response = await ApiService.get(ApiConfig.orders);
      
      // La respuesta puede ser una lista directa o un objeto con 'results'
      final List<dynamic> ordersJson = (response is List 
          ? response 
          : (response['results'] as List? ?? [])) as List<dynamic>;
      
      return ordersJson.map((json) => Order.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }
  
  // Get order by ID
  static Future<Order> getOrder(int id) async {
    try {
      final response = await ApiService.get('${ApiConfig.orders}$id/');
      return Order.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
  
  // Create order (checkout)
  static Future<Order> createOrder({
    required String paymentMethod,
    String? shippingAddress,
    String? notes,
  }) async {
    try {
      final response = await ApiService.post(
        ApiConfig.orders,
        {
          'payment_method': paymentMethod,
          if (shippingAddress != null) 'shipping_address': shippingAddress,
          if (notes != null) 'notes': notes,
        },
      );
      
      return Order.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
  
  // Cancel order
  static Future<Order> cancelOrder(int orderId) async {
    try {
      final response = await ApiService.put(
        '${ApiConfig.orders}$orderId/',
        {'status': 'CANCELLED'},
      );
      
      return Order.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
