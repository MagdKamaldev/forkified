import 'package:flutter/material.dart';
import 'package:forkified/models/recipe_model.dart';

class Collection {
  String? id;
  String? name;
  List<RecipeModel?>? recipes;

  Collection({this.id, this.name, this.recipes});

  factory Collection.fromJson(Map<String, dynamic> json) {
    try {
      return Collection(
        id: json['_id'] as String?,
        name: json['name'] as String?,
        recipes: (json['recipes'] as List<dynamic>?)?.map((e) {
          if (e is String) {
            // If it's a string, create a RecipeModel with only the ID
            return RecipeModel(id: e);
          } else if (e is Map<String, dynamic>) {
            // If it's a map, parse it as a RecipeModel
            return RecipeModel.fromJson(e);
          } else {
            // Handle other cases or return null if appropriate
            return null;
          }
        }).toList(),
      );
    } catch (e) {
      debugPrint('Error parsing Collection: $e');
      debugPrint('JSON data: $json');
      rethrow; // Rethrow the exception after logging information
    }
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'recipes': recipes?.map((e) => e?.toJson()).toList(),
      };
}
