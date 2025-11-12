import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../services/api_service.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  bool _isLoading = false;
  String? _error;
  
  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _user != null;
  
  // Initialize - Load tokens and user data
  Future<void> initialize() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      await ApiService.loadTokens();
      
      if (AuthService.isAuthenticated) {
        _user = await AuthService.getProfile();
      }
    } catch (e) {
      _error = e.toString();
      await logout(); // Clear invalid tokens
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  // Login
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      final response = await AuthService.login(email, password);
      
      // Get user profile
      _user = await AuthService.getProfile();
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
  
  // Register
  Future<bool> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? phone,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      await AuthService.register(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        phone: phone,
      );
      
      // Auto login after registration
      final loginSuccess = await login(email, password);
      
      _isLoading = false;
      notifyListeners();
      return loginSuccess;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
  
  // Logout
  Future<void> logout() async {
    await AuthService.logout();
    _user = null;
    _error = null;
    notifyListeners();
  }
  
  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
