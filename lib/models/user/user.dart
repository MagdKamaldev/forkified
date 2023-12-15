import 'package:forkified/models/review/review.dart';
import 'package:forkified/models/user/collection.dart';

class User {
  String? id;
  String? name;
  String? email;
  int? v;
  String? role;
  List<Collection?>? collections;
  List<Review?>? reviews;

  User(
      {this.id,
      this.name,
      this.email,
      this.v,
      this.role,
      this.collections,
      this.reviews});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      v: json['__v'] as int?,
      role: json['role'] as String?,
      collections: (json['collections'] as List<dynamic>?)
          ?.map((e) => e == null ? null : Collection.fromJson(e))
          .toList(),
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => e == null ? null : Review.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'email': email,
        '__v': v,
        'role': role,
        'collections': collections?.map((e) => e?.toJson()).toList(),
        'reviews': reviews?.map((e) => e?.toJson()).toList(),
      };
}
