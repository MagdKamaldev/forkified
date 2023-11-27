import 'collection.dart';

class User {
  String? id;
  String? name;
  String? email;
  int? v;
  List<Collection>? collections;

  User({this.id, this.name, this.email, this.v, this.collections});

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['_id'] as String?,
        name: json['name'] as String?,
        email: json['email'] as String?,
        v: json['__v'] as int?,
        collections: (json['collections'] as List<dynamic>?)
            ?.map((e) => Collection.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'email': email,
        '__v': v,
        'collections': collections?.map((e) => e.toJson()).toList(),
      };
}
