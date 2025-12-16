import 'package:flutter/material.dart';
import '../data/models/user_model.dart';
import '../data/services/auth_service.dart';
import '../data/storage/storage_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  final StorageService _storageService = StorageService();

  User? _currentUser;
  bool _isLoading = false;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _currentUser != null;

  // Check if user is already logged in (on app start)
  Future<void> checkAuthStatus() async {
    final token = await _storageService.getToken();
    final user = await _storageService.getUser();

    if (token != null && user != null) {
      _currentUser = user;
      notifyListeners();
    }
  }

  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final data = await _authService.login(email, password);
      final token = data['token'];
      final user = User.fromJson(data['user']);

      await _storageService.saveToken(token);
      await _storageService.saveUser(user);

      _currentUser = user;
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> register(String name, String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final data = await _authService.register(name, email, password);
      // NOTE: Usually registration also logs you in, API returns token/user. Same as login.
      final token = data['token'];
      final user = User.fromJson(data['user']);
      
      // If we want to auto-login after register:
      await _storageService.saveToken(token);
      await _storageService.saveUser(user);
      _currentUser = user;

    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _authService.logout();
    } finally {
      await _storageService.clearAll();
      _currentUser = null;
      _isLoading = false;
      notifyListeners();
    }
  }
}
