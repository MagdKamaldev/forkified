class RecipeModel {
  String? id;
  String? name;
  String? description;
  String? image;
  List<String>? ingredients; 
  int? prepTime;
  int? calories;
  bool? vegetarian; 
  String? category;
  String? subcategory;
  int? v;
  String? diet;

  RecipeModel({
    this.id,
    this.name,
    this.description,
    this.image,
    this.ingredients,
    this.prepTime,
    this.calories,
    this.vegetarian,
    this.category,
    this.subcategory,
    this.v,
    this.diet,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      ingredients: (json['ingredients'] as List<dynamic>?)
          ?.map((ingredient) => ingredient as String)
          .toList(),
      prepTime: json['prep_time'] as int?,
      calories: json['calories'] as int?,
      vegetarian: json['vegetarian'] as bool?, // Parse boolean
      category: json['category'] as String?,
      subcategory: json['subcategory'] as String?,
      v: json['__v'] as int?,
      diet: json['diet'] as String?, // Added diet field
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'description': description,
        'image': image,
        'ingredients': ingredients,
        'prep_time': prepTime,
        'calories': calories,
        'vegetarian': vegetarian,
        'category': category,
        'subcategory': subcategory,
        '__v': v,
        'diet': diet,
      };
}
