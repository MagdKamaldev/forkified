import 'package:forkified/models/recipe_model.dart';

class Collection {
  String? id;
  String? name;
  List<RecipeModel?>? recipes;

  Collection({this.id, this.name, this.recipes});

  factory Collection.fromJson(Map<String, dynamic> json) {
    return Collection(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      recipes: (json['recipes'] as List<dynamic>?)
          ?.map((e) => e == null ? null : RecipeModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'recipes': recipes?.map((e) => e?.toJson()).toList(),
      };
}