import 'package:forkified/models/sub_category.dart';

class CategoryModel {
  String? id;
  String? name;
  String? description;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  List<SubCategory>? subcategories;

  CategoryModel({
    this.id,
    this.name,
    this.description,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.subcategories,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json['_id'] as String?,
        name: json['name'] as String?,
        description: json['description'] as String?,
        image: json['image'] as String?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
        v: json['__v'] as int?,
        subcategories: (json['subcategories'] as List<dynamic>?)
            ?.map((subJson) => SubCategory.fromJson(subJson))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'description': description,
        'image': image,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        '__v': v,
        'subcategories': subcategories?.map((sub) => sub.toJson()).toList(),
      };
}
