import 'package:forkified/models/user/user.dart';
import 'package:forkified/models/recipe_model.dart'; // Import the RecipeModel class

class Review {
  String? id;
  String? title;
  int? rating;
  User? user;
  RecipeModel? recipe; // Change the type to RecipeModel
  int? v;

  Review({
    this.id,
    this.title,
    this.rating,
    this.user,
    this.recipe,
    this.v,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json['_id'] as String?,
        title: json['title'] as String?,
        rating: json['rating'] as int?,
        user: json['user'] == null
            ? null
            : User.fromJson(json['user'] as Map<String, dynamic>),
        recipe: json['recipe'] == null
            ? null
            : RecipeModel.fromJson(json['recipe'] as Map<String, dynamic>),
        v: json['__v'] as int?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'title': title,
        'rating': rating,
        'user': user?.toJson(),
        'recipe': recipe?.toJson(), // Convert RecipeModel to JSON
        '__v': v,
      };
}
