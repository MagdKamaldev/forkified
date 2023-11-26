class SubCategory {
  String? id;
  String? name;
  String? description;
  String? category;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  SubCategory({
    this.id,
    this.name,
    this.description,
    this.category,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        id: json['_id'] as String?,
        name: json['name'] as String?,
        description: json['description'] as String?,
        category: json['category'] as String?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
        v: json['__v'] as int?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'description': description,
        'category': category,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        '__v': v,
      };
}
