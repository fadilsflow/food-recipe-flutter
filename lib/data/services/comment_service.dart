import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';
import '../models/comment_model.dart';
import 'dio_client.dart';

class CommentService {
  final DioClient _dioClient;

  CommentService() : _dioClient = DioClient();

  Future<Map<String, dynamic>> getComments(int recipeId) async {
    try {
      final response = await _dioClient.dio.get(
        '${ApiConstants.recipesEndpoint}/$recipeId/comments',
      );

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        final List<dynamic> commentsData = response.data['data']['comments'];
        final comments = commentsData.map((json) => Comment.fromJson(json)).toList();
        return {
          'comments': comments,
          'comment_count': response.data['data']['comment_count'] ?? 0,
        };
      } else {
        throw Exception(response.data['message'] ?? 'Failed to load comments');
      }
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Connection error');
    }
  }

  Future<Comment> addComment(int recipeId, String comment) async {
    try {
      final response = await _dioClient.dio.post(
        '${ApiConstants.recipesEndpoint}/$recipeId/comments',
        data: {'comment': comment},
      );

      if (response.statusCode == 201 && response.data['status'] == 'success') {
        return Comment.fromJson(response.data['data']);
      } else {
        if (response.data['errors'] != null) {
          String errorMessage = '';
          (response.data['errors'] as Map).forEach((key, value) {
            errorMessage += "${value[0]}\n";
          });
          throw Exception(errorMessage.trim());
        }
        throw Exception(response.data['message'] ?? 'Failed to add comment');
      }
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Connection error');
    }
  }

  Future<void> deleteComment(int recipeId, int commentId) async {
    try {
      final response = await _dioClient.dio.delete(
        '${ApiConstants.recipesEndpoint}/$recipeId/comments/$commentId',
      );

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        return;
      } else {
        throw Exception(response.data['message'] ?? 'Failed to delete comment');
      }
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Connection error');
    }
  }
}
