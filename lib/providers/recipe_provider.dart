import 'dart:io';
import 'package:flutter/material.dart';
import '../data/models/recipe_model.dart';
import '../data/services/recipe_service.dart';

class RecipeProvider with ChangeNotifier {
  final RecipeService _recipeService = RecipeService();

  List<Recipe> _recipes = [];
  bool _isLoading = false;

  List<Recipe> get recipes => _recipes;
  bool get isLoading => _isLoading;

  Future<void> fetchRecipes() async {
    _isLoading = true;
    notifyListeners();

    try {
      _recipes = await _recipeService.getRecipes();
    } catch (e) {
      // You might want to handle error state here
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
    required File photo,
  }) async {
    _isLoading = true;
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
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteRecipe(int id) async {
    // Optimistic update or wait? Let's wait.
    try {
      await _recipeService.deleteRecipe(id);
      _recipes.removeWhere((r) => r.id == id);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
