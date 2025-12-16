import 'user_model.dart';

class Comment {
  final int id;
  final int userId;
  final int recipeId;
  final String comment;
  final DateTime createdAt;
  final DateTime updatedAt;
  final User? user;

  Comment({
    required this.id,
    required this.userId,
    required this.recipeId,
    required this.comment,
    required this.createdAt,
    required this.updatedAt,
    this.user,
  });

  static int _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is String) return int.parse(value);
    return 0;
  }

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: _parseInt(json['id']),
      userId: _parseInt(json['user_id']),
      recipeId: _parseInt(json['recipe_id']),
      comment: json['comment'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'recipe_id': recipeId,
      'comment': comment,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'user': user?.toJson(),
    };
  }
}
