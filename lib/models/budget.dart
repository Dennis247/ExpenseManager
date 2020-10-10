import 'package:flutter/cupertino.dart';

class Budget {
  final String id;
  final double amount;
  final String categoryId;
  final String yearMonth;

  Budget(
      {@required this.id,
      @required this.amount,
      @required this.categoryId,
      @required this.yearMonth});

  static List<Budget> listFromJson(List collection) {
    List<Budget> list =
        collection.map((json) => Budget.fromJson(json)).toList();
    return list;
  }

  Budget.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        amount = json['amount'],
        categoryId = json['categoryId'],
        yearMonth = json['dateTime'];
}
