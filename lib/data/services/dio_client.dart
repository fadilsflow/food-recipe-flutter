import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';
import '../storage/storage_service.dart';

class DioClient {
  final Dio _dio;
  final StorageService _storageService = StorageService();

  DioClient()
      : _dio = Dio(
          BaseOptions(
            baseUrl: ApiConstants.baseUrl,
            connectTimeout: const Duration(seconds: 30), // Increased for file uploads
            receiveTimeout: const Duration(seconds: 60), // Increased for file uploads
            sendTimeout: const Duration(seconds: 60), // Added for file uploads
            responseType: ResponseType.json,
            validateStatus: (status) {
              return status! < 500; // Let us handle 4xx errors
            },
          ),
        ) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _storageService.getToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
            print('🔑 Token attached: ${token.substring(0, 20)}...'); // Debug
          } else {
            print('⚠️ No token found in storage'); // Debug
          }
          options.headers['Accept'] = 'application/json';
          print('📤 ${options.method} ${options.uri}'); // Debug
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print('📥 Response [${response.statusCode}]: ${response.requestOptions.uri}'); // Debug
          return handler.next(response);
        },
        onError: (error, handler) {
          print('❌ Error: ${error.message}'); // Debug
          print('❌ Response: ${error.response?.data}'); // Debug
          return handler.next(error);
        },
      ),
    );
  }

  Dio get dio => _dio;
}
