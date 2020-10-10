import 'dart:math';

import 'package:expense_tracker/models/budget.dart';
import 'package:expense_tracker/models/category.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/utils/helpers.dart';
import 'package:expense_tracker/viewmodels/chartCategory.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MOckData {
  static List<Expense> expenseList = [
    //2020 expense
    Expense(
      id: "1",
      categoryId: "1",
      amount: 5000,
      yearMonth: "2020-10",
    ),

    Expense(
      id: "2",
      categoryId: "2",
      amount: 5000,
      yearMonth: "2020-10",
    ),

    Expense(
      id: "3",
      categoryId: "3",
      amount: 5000,
      yearMonth: "2020-10",
    ),
    Expense(
      id: "4",
      categoryId: "4",
      amount: 5000,
      yearMonth: "2020-10",
    ),
    Expense(
      id: "5",
      categoryId: "5",
      amount: 5000,
      yearMonth: "2020-10",
    ),
  ];

  static List<Category> categoryLIst = [
    Category(id: "1", name: "Food", iconData: FontAwesomeIcons.caretRight),
    Category(id: "2", name: "School", iconData: FontAwesomeIcons.school),
    Category(id: "3", name: "Music", iconData: FontAwesomeIcons.music),
    Category(id: "4", name: "Health", iconData: FontAwesomeIcons.hospital),
    Category(id: "5", name: "Shopping", iconData: FontAwesomeIcons.shopify)
  ];

  static List<ChartCategory> monthlyExpenseList = [
    ChartCategory(
        itemId: "1",
        count: 10,
        category: "Food",
        chartColor: charts.ColorUtil.fromDartColor(Colors.green),
        yearMonth: Helpers.getFormattedDate(DateTime.now())),
    ChartCategory(
        itemId: "2",
        count: 5,
        category: "School",
        chartColor: charts.ColorUtil.fromDartColor(Colors.red),
        yearMonth: Helpers.getFormattedDate(DateTime.now())),
    ChartCategory(
        itemId: "3",
        count: 2,
        category: "Music",
        chartColor: charts.ColorUtil.fromDartColor(Colors.yellow),
        yearMonth: Helpers.getFormattedDate(DateTime.now())),
    ChartCategory(
        itemId: "4",
        count: 40,
        category: "Health",
        chartColor: charts.ColorUtil.fromDartColor(Colors.blue),
        yearMonth: Helpers.getFormattedDate(DateTime.now())),
    ChartCategory(
        itemId: "5",
        count: 60,
        category: "Drinks",
        chartColor: charts.ColorUtil.fromDartColor(Colors.purple),
        yearMonth: Helpers.getFormattedDate(DateTime.now())),
  ];

  static List<Budget> budgetlist = [
    Budget(id: "1", amount: 5000, categoryId: "1", yearMonth: "2020-09"),
    Budget(id: "2", amount: 5000, categoryId: "2", yearMonth: "2020-09"),
    Budget(id: "3", amount: 5000, categoryId: "3", yearMonth: "2020-09"),
    Budget(id: "4", amount: 5000, categoryId: "4", yearMonth: "2020-09"),
    Budget(id: "5", amount: 5000, categoryId: "5", yearMonth: "2020-09")
  ];
}
