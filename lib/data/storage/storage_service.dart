import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class StorageService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  
  // Keys
  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'user_data';

  // Token Management (Secure Storage)
  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: _tokenKey, value: token);
  }

  Future<String?> getToken() async {
    return await _secureStorage.read(key: _tokenKey);
  }

  Future<void> deleteToken() async {
    await _secureStorage.delete(key: _tokenKey);
  }

  // User Management (Shared Preferences)
  Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    String userJson = jsonEncode(user.toJson());
    await prefs.setString(_userKey, userJson);
  }

  Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString(_userKey);
    if (userJson == null) return null;
    try {
      return User.fromJson(jsonDecode(userJson));
    } catch (e) {
      return null;
    }
  }

  Future<void> deleteUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }

  Future<void> clearAll() async {
    await deleteToken();
    await deleteUser();
  }
}
