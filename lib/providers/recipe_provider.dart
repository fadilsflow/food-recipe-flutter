import 'package:flutter/material.dart';
import '../data/models/recipe_model.dart';
import '../data/services/recipe_service.dart';

class RecipeProvider with ChangeNotifier {
  final RecipeService _recipeService = RecipeService();

  List<Recipe> _recipes = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Recipe> get recipes => _recipes;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchRecipes() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _recipes = await _recipeService.getRecipes();
    } catch (e) {
      _errorMessage = e.toString();
      print('Error fetching recipes: $e'); // Debug log
      rethrow; 
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addRecipe({
    required String title,
    required String cookingMethod,
    required String ingredients,
    required String description,
    required dynamic photo, // Changed from File to dynamic for web compatibility
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final newRecipe = await _recipeService.createRecipe(
        title: title,
        cookingMethod: cookingMethod,
        ingredients: ingredients,
        description: description,
        photo: photo,
      );
      _recipes.insert(0, newRecipe); // Add to top
    } catch (e) {
      _errorMessage = e.toString();
      print('Error adding recipe: $e'); // Debug log
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteRecipe(int id) async {
    try {
      await _recipeService.deleteRecipe(id);
      _recipes.removeWhere((r) => r.id == id);
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      print('Error deleting recipe: $e'); // Debug log
      rethrow;
    }
  }
}
