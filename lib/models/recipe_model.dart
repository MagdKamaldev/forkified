class RecipeModel {
  String? id;
  String? name;
  String? description;
  String? image;
  List<dynamic>? ingredients;
  int? prepTime;
  int? calories;
  String? category;
  String? subcategory;
  int? v;

  RecipeModel({
    this.id,
    this.name,
    this.description,
    this.image,
    this.ingredients,
    this.prepTime,
    this.calories,
    this.category,
    this.subcategory,
    this.v,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) => RecipeModel(
        id: json['_id'] as String?,
        name: json['name'] as String?,
        description: json['description'] as String?,
        image: json['image'] as String?,
        ingredients: json['ingredients'] as List<dynamic>?,
        prepTime: json['prep_time'] as int?,
        calories: json['calories'] as int?,
        category: json['category'] as String?,
        subcategory: json['subcategory'] as String?,
        v: json['__v'] as int?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'description': description,
        'image': image,
        'ingredients': ingredients,
        'prep_time': prepTime,
        'calories': calories,
        'category': category,
        'subcategory': subcategory,
        '__v': v,
      };
}
