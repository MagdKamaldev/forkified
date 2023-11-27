class Collection {
  String? name;
  List<dynamic>? recipes;
  String? id;

  Collection({this.name, this.recipes, this.id});

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
        name: json['name'] as String?,
        recipes: json['recipes'] as List<dynamic>?,
        id: json['_id'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'recipes': recipes,
        '_id': id,
      };
}
