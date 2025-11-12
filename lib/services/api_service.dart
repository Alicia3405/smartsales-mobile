import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../core/config/api_config.dart';

class ApiService {
  static String? _accessToken;
  static String? _refreshToken;
  
  // Headers base
  static Future<Map<String, String>> _getHeaders({bool requiresAuth = true}) async {
    final headers = {
      'Content-Type': 'application/json',
    };
    
    if (requiresAuth && _accessToken != null) {
      headers['Authorization'] = 'Bearer $_accessToken';
    }
    
    return headers;
  }
  
  // Guardar tokens
  static Future<void> saveTokens(String access, String refresh) async {
    _accessToken = access;
    _refreshToken = refresh;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', access);
    await prefs.setString('refresh_token', refresh);
  }
  
  // Cargar tokens
  static Future<void> loadTokens() async {
    final prefs = await SharedPreferences.getInstance();
    _accessToken = prefs.getString('access_token');
    _refreshToken = prefs.getString('refresh_token');
  }
  
  // Limpiar tokens
  static Future<void> clearTokens() async {
    _accessToken = null;
    _refreshToken = null;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
  }
  
  // Verificar si está autenticado
  static bool get isAuthenticated => _accessToken != null;
  
  // GET request
  static Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, String>? queryParams,
    bool requiresAuth = true,
  }) async {
    try {
      final uri = Uri.parse('${ApiConfig.baseUrl}$endpoint')
          .replace(queryParameters: queryParams);
      
      final headers = await _getHeaders(requiresAuth: requiresAuth);
      
      final response = await http.get(uri, headers: headers)
          .timeout(ApiConfig.connectionTimeout);
      
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }
  
  // POST request
  static Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> body, {
    bool requiresAuth = true,
  }) async {
    try {
      final uri = Uri.parse('${ApiConfig.baseUrl}$endpoint');
      final headers = await _getHeaders(requiresAuth: requiresAuth);
      
      final response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(body),
      ).timeout(ApiConfig.connectionTimeout);
      
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }
  
  // PUT request
  static Future<Map<String, dynamic>> put(
    String endpoint,
    Map<String, dynamic> body, {
    bool requiresAuth = true,
  }) async {
    try {
      final uri = Uri.parse('${ApiConfig.baseUrl}$endpoint');
      final headers = await _getHeaders(requiresAuth: requiresAuth);
      
      final response = await http.put(
        uri,
        headers: headers,
        body: jsonEncode(body),
      ).timeout(ApiConfig.connectionTimeout);
      
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }
  
  // DELETE request
  static Future<Map<String, dynamic>> delete(
    String endpoint, {
    bool requiresAuth = true,
  }) async {
    try {
      final uri = Uri.parse('${ApiConfig.baseUrl}$endpoint');
      final headers = await _getHeaders(requiresAuth: requiresAuth);
      
      final response = await http.delete(uri, headers: headers)
          .timeout(ApiConfig.connectionTimeout);
      
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }
  
  // Manejar respuesta
  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) {
        return {'success': true};
      }
      return jsonDecode(response.body);
    } else {
      final error = response.body.isNotEmpty
          ? jsonDecode(response.body)
          : {'error': 'Error desconocido'};
      throw ApiException(
        error['error']?.toString() ?? error['detail']?.toString() ?? 'Error en la petición',
        response.statusCode,
      );
    }
  }
  
  // Manejar errores
  static String _handleError(dynamic error) {
    if (error is ApiException) {
      return error.message;
    }
    return 'Error de conexión. Verifica tu internet.';
  }
}

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  
  ApiException(this.message, [this.statusCode]);
  
  @override
  String toString() => message;
}
