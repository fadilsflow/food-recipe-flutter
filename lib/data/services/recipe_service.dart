import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';
import '../models/recipe_model.dart';
import 'dio_client.dart';
import 'package:http_parser/http_parser.dart';

// Conditional imports for web/mobile compatibility
import 'recipe_service_stub.dart'
    if (dart.library.io) 'recipe_service_mobile.dart'
    if (dart.library.html) 'recipe_service_web.dart' as platform;

class RecipeService {
  final DioClient _dioClient;

  RecipeService() : _dioClient = DioClient();

  Future<List<Recipe>> getRecipes() async {
    try {
      final response = await _dioClient.dio.get(ApiConstants.recipesEndpoint);

        if (response.statusCode == 200 && response.data['status'] == 'success') {
        final List<dynamic> data = response.data['data']['data']; // Pagination structure
        return data.map((json) => Recipe.fromJson(json)).toList();
      } else {
        throw Exception(response.data['message'] ?? 'Failed to load recipes');
      }
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Connection error');
    }
  }

  Future<Recipe> createRecipe({
    required String title,
    required String cookingMethod,
    required String ingredients,
    required String description,
    required dynamic photo, // Changed from File to dynamic for web compatibility
  }) async {
    try {
      // Use platform-specific implementation
      final multipartFile = await platform.createMultipartFile(photo);
      
      FormData formData = FormData.fromMap({
        'title': title,
        'cooking_method': cookingMethod,
        'ingredients': ingredients,
        'description': description,
        'photo': multipartFile,
      });

      final response = await _dioClient.dio.post(
        ApiConstants.recipesEndpoint,
        data: formData,
      );

      if (response.statusCode == 201 && response.data['status'] == 'success') {
         return Recipe.fromJson(response.data['data']);
      } else {
         if (response.data['errors'] != null) {
          String errorMessage = '';
          (response.data['errors'] as Map).forEach((key, value) {
            errorMessage += "${value[0]}\n";
          });
          throw Exception(errorMessage.trim());
        }
        throw Exception(response.data['message'] ?? 'Failed to create recipe');
      }
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Connection error');
    }
  }

  Future<void> deleteRecipe(int id) async {
    try {
      final response = await _dioClient.dio.delete("${ApiConstants.recipesEndpoint}/$id");

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        return;
      } else {
        throw Exception(response.data['message'] ?? 'Failed to delete recipe');
      }
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Connection error');
    }
  }
}
