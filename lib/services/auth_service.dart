import '../core/config/api_config.dart';
import '../models/user_model.dart';
import 'api_service.dart';

class AuthService {
  // Login
  static Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await ApiService.post(
        ApiConfig.login,
        {
          'username': email,  // JWT usa username, no email
          'password': password,
        },
        requiresAuth: false,
      );
      
      // Guardar tokens
      if (response['access'] != null && response['refresh'] != null) {
        await ApiService.saveTokens(response['access'], response['refresh']);
      }
      
      return response;
    } catch (e) {
      rethrow;
    }
  }
  
  // Register
  static Future<Map<String, dynamic>> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? phone,
  }) async {
    try {
      final data = {
        'username': email,  // Usar email como username
        'email': email,
        'password': password,
        'first_name': firstName,
        'last_name': lastName,
        if (phone != null) 'phone': phone,
        'role': 'CLIENT',  // Rol correcto en mayúsculas
      };
      
      print('🔍 Datos enviados desde móvil: $data');
      
      final response = await ApiService.post(
        ApiConfig.register,
        data,
        requiresAuth: false,
      );
      
      return response;
    } catch (e) {
      rethrow;
    }
  }
  
  // Get Profile
  static Future<User> getProfile() async {
    try {
      final response = await ApiService.get(ApiConfig.profile);
      return User.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
  
  // Logout
  static Future<void> logout() async {
    await ApiService.clearTokens();
  }
  
  // Check if authenticated
  static bool get isAuthenticated => ApiService.isAuthenticated;
}
