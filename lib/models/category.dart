import 'package:flutter/cupertino.dart';

class Category {
  final String id;
  final String name;
  final IconData iconData;

  Category({@required this.id, @required this.name, @required this.iconData});

  static List<Category> listFromJson(List collection) {
    List<Category> list =
        collection.map((json) => Category.fromJson(json)).toList();
    return list;
  }

  Category.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        iconData = json['iconData'];
}
