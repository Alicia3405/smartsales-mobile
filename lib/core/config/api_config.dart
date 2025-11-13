class ApiConfig {
  // IMPORTANTE: Cambia esta URL por la IP de tu servidor backend
  // Si estás usando un emulador de Android, usa 10.0.2.2 en lugar de localhost
  // Si estás usando un dispositivo físico, usa la IP de tu computadora en la red local
  static const String baseUrl = 'http://localhost:3000';
  
  // Endpoints de autenticación
  static const String login = '/api/v1/token/';
  static const String register = '/api/v1/register/';
  static const String refreshToken = '/api/v1/token/refresh/';
  static const String profile = '/api/v1/perfil/';
  
  // Endpoints de productos
  static const String products = '/api/v1/productos/';
  static const String categories = '/api/v1/categorias/';
  
  // Endpoints de ventas
  static const String cart = '/api/v1/carrito/';
  static const String orders = '/api/v1/pedidos/';
  static const String checkout = '/api/v1/checkout/';
  static const String payment = '/api/v1/pago/';
  
  // Timeouts
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}
