// Ejemplo de configuración después del despliegue
class ApiConfig {
  // PRODUCCIÓN: URL del backend desplegado en Google Cloud Run
  static const String baseUrl = 'https://smartsales-backend-xxx-uc.a.run.app';
  
  // DESARROLLO: Para testing local
  // static const String baseUrl = 'http://10.0.2.2:8000';  // Emulador Android
  // static const String baseUrl = 'http://192.168.1.XXX:8000';  // Dispositivo físico
  
  // Endpoints de autenticación
  static const String login = '/api/v1/token/';
  static const String register = '/api/v1/register/';
  static const String refreshToken = '/api/v1/token/refresh/';
  static const String profile = '/api/v1/perfil/';
  
  // Endpoints de productos
  static const String products = '/api/v1/productos/';
  static const String categories = '/api/v1/categorias/';
  
  // Endpoints de carrito y pedidos
  static const String cart = '/api/v1/carrito/';
  static const String orders = '/api/v1/pedidos/';
  static const String checkout = '/api/v1/checkout/';
  
  // Configuración de timeouts
  static const int connectTimeout = 30000; // 30 segundos
  static const int receiveTimeout = 30000; // 30 segundos
}
