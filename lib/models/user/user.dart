import 'collection.dart';

class User {
  String? id;
  String? name;
  String? email;
  int? v;
  String? role;
  List<Collection?>? collections;

  User({this.id, this.name, this.email, this.v, this.role, this.collections});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      v: json['__v'] as int?,
      role: json['role'] as String?, // Add this line for the 'role' field
      collections: (json['collections'] as List<dynamic>?)
          ?.map((e) => e == null ? null : Collection.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'email': email,
        '__v': v,
        'role': role, // Add this line for the 'role' field
        'collections': collections?.map((e) => e?.toJson()).toList(),
      };
}
