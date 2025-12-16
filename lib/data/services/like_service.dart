import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';
import 'dio_client.dart';

class LikeService {
  final DioClient _dioClient;

  LikeService() : _dioClient = DioClient();

  Future<Map<String, dynamic>> toggleLike(int recipeId) async {
    try {
      final response = await _dioClient.dio.post(
        '${ApiConstants.recipesEndpoint}/$recipeId/like',
      );

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        return {
          'is_liked': response.data['data']['is_liked'] ?? false,
          'like_count': response.data['data']['like_count'] ?? 0,
        };
      } else {
        throw Exception(response.data['message'] ?? 'Failed to toggle like');
      }
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Connection error');
    }
  }

  Future<Map<String, dynamic>> getLikes(int recipeId) async {
    try {
      final response = await _dioClient.dio.get(
        '${ApiConstants.recipesEndpoint}/$recipeId/likes',
      );

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        return {
          'like_count': response.data['data']['like_count'] ?? 0,
          'is_liked': response.data['data']['is_liked'] ?? false,
        };
      } else {
        throw Exception(response.data['message'] ?? 'Failed to get likes');
      }
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Connection error');
    }
  }
}
