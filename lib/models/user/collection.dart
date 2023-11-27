import 'package:forkified/models/recipe_model.dart';

class Collection {
  String? name;
  List<RecipeModel?>? recipes;
  String? id;

  Collection({this.name, this.recipes, this.id});

  factory Collection.fromJson(Map<String, dynamic> json) {
    return Collection(
      name: json['name'] as String?,
      recipes: (json['recipes'] as List<dynamic>?)
          ?.map((e) => e == null ? null : RecipeModel.fromJson(e))
          .toList(),
      id: json['_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'recipes': recipes?.map((e) => e?.toJson()).toList(),
        '_id': id,
      };
}
