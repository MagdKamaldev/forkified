import 'package:forkified/models/review/review.dart';

class RecipeModel {
  String? id;
  String? name;
  String? description;
  String? image;
  List<String>? ingredients;
  int? prepTime;
  int? calories;
  bool? vegetarian;
  Map<String, dynamic>? category;
  Map<String, dynamic>? subcategory;
  int? v;
  String? diet;
  int? ratingsQuantity;
  num? ratingsAverage; // Updated to double
  List<Review>? reviews;

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
    this.ratingsQuantity,
    this.ratingsAverage,
    this.reviews,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      ratingsAverage: json['ratingsAverage'] as num?,
      ratingsQuantity: json['ratingsQuantity'] as int?,
      ingredients: (json['ingredients'] as List<dynamic>?)
          ?.map((ingredient) => ingredient as String)
          .toList(),
      prepTime: json['prep_time'] as int?,
      calories: json['calories'] as int?,
      vegetarian: json['vegetarian'] as bool?,
      category: json['category'] as Map<String, dynamic>?,
      subcategory: json['subcategory'] as Map<String, dynamic>?,
      v: json['__v'] as int?,
      diet: json['diet'] as String?, // Added diet field
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((review) => Review.fromJson(review))
          .toList(), // Parse reviews
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'ratingsAverage': ratingsAverage,
        'ratingsQuantity': ratingsQuantity,
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
        'reviews': reviews?.map((review) => review.toJson()).toList(),
      };
}
