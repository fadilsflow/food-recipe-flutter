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
            connectTimeout: const Duration(milliseconds: 5000),
            receiveTimeout: const Duration(milliseconds: 3000),
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
          }
          options.headers['Accept'] = 'application/json';
          return handler.next(options);
        },
      ),
    );
  }

  Dio get dio => _dio;
}
