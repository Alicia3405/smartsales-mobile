class ApiConfig {
  // IMPORTANTE: URL del backend desplegado en Google Cloud Run
  // Reemplaza con tu URL real después del despliegue

  static const String kBaseUrlCloud = 'https://smartsales-backend-783403173685.europe-west1.run.app'; // NUBE
  static const String kBaseUrlLocal = 'http://10.0.2.2:8000'; // LOCAL (emulador)
  
  // URL activa - cambiar entre producción y desarrollo
  static const String baseUrl = kBaseUrlCloud; // PRODUCCIÓN
  // static const String baseUrl = 'http://localhost:8000'; // DESARROLLO LOCAL

  // Endpoints de autenticación
  static const String login = '/api/v1/token/';
  static const String register = '/api/v1/register/';
  static const String refreshToken = '/api/v1/token/refresh/';
  static const String profile = '/api/v1/perfil/';

  // Endpoints de productos (en español como en el backend)
  static const String products = '/api/v1/productos/';
  static const String categories = '/api/v1/categorias/';

  // Endpoints de ventas (corregidos)
  static const String cart = '/api/v1/cart/';
  static const String orders = '/api/v1/orders/';
  static const String checkout = '/api/v1/checkout/';
  static const String payment = '/api/v1/payment/';

  // Timeouts
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}
