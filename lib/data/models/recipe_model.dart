import 'user_model.dart';

class Recipe {
  final int id;
  final int userId;
  final String title;
  final String description;
  final String cookingMethod;
  final String ingredients;
  final String photoUrl;
  final DateTime createdAt;
  final int likesCount;
  final int commentsCount;
  final User? user;
  final bool isLiked; // Added for like status

  Recipe({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.cookingMethod,
    required this.ingredients,
    required this.photoUrl,
    required this.createdAt,
    required this.likesCount,
    required this.commentsCount,
    this.user,
    this.isLiked = false, // Default to false
  });

  // Helper function to safely parse integers from dynamic values
  static int _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is String) return int.parse(value);
    return 0;
  }

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: _parseInt(json['id']),
      userId: _parseInt(json['user_id']),
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      cookingMethod: json['cooking_method'] ?? '',
      ingredients: json['ingredients'] ?? '',
      photoUrl: json['photo_url'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
      likesCount: _parseInt(json['likes_count'] ?? 0),
      commentsCount: _parseInt(json['comments_count'] ?? 0),
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      isLiked: json['is_liked'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'description': description,
      'cooking_method': cookingMethod,
      'ingredients': ingredients,
      'photo_url': photoUrl,
      'created_at': createdAt.toIso8601String(),
      'likes_count': likesCount,
      'comments_count': commentsCount,
      'user': user?.toJson(),
    };
  }
}
