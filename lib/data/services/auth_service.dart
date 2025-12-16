import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';
import '../models/user_model.dart';
import 'dio_client.dart';

class AuthService {
  final DioClient _dioClient;

  AuthService() : _dioClient = DioClient();

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _dioClient.dio.post(
        ApiConstants.loginEndpoint,
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        return response.data['data'];
      } else {
        throw Exception(response.data['message'] ?? 'Login failed');
      }
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Connection error');
    }
  }

  Future<Map<String, dynamic>> register(String name, String email, String password) async {
    try {
      final response = await _dioClient.dio.post(
        ApiConstants.registerEndpoint,
        data: {
          'name': name,
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 201 && response.data['status'] == 'success') {
        return response.data['data'];
      } else {
        // Handle validation errors or other 4xx
        if (response.data['errors'] != null) {
          String errorMessage = '';
          (response.data['errors'] as Map).forEach((key, value) {
            errorMessage += "${value[0]}\n";
          });
          throw Exception(errorMessage.trim());
        }
        throw Exception(response.data['message'] ?? 'Registration failed');
      }
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Connection error');
    }
  }

  Future<void> logout() async {
    try {
      await _dioClient.dio.post(ApiConstants.logoutEndpoint);
    } catch (e) {
      // Ignore logout errors (e.g. token already expired)
    }
  }
}
