import 'package:flutter/cupertino.dart';

class Expense {
  final String id;
  final String categoryId;
  final int amount;
  final String yearMonth;

  Expense(
      {@required this.id,
      @required this.categoryId,
      @required this.amount,
      @required this.yearMonth});

  static List<Expense> listFromJson(List collection) {
    List<Expense> list =
        collection.map((json) => Expense.fromJson(json)).toList();
    return list;
  }

  Expense.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        categoryId = json['categoryId'],
        amount = json['amount'],
        yearMonth = json['yearMonth'];
}
