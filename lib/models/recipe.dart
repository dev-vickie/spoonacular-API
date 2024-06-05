// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Recipe {
  final int id;
  final String title;
  final String image;
  final String imageType;

  Recipe({
    required this.id,
    required this.title,
    required this.image,
    required this.imageType,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'image': image,
      'imageType': imageType,
    };
  }

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map['id'] as int,
      title: map['title'] as String,
      image: map['image'] as String,
      imageType: map['imageType'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Recipe.fromJson(String source) => Recipe.fromMap(json.decode(source) as Map<String, dynamic>);
}
