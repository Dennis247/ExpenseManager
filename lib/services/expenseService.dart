import 'package:expense_tracker/Data/mockData.dart';
import 'package:expense_tracker/main.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/models/response.dart';
import 'package:expense_tracker/services/categoryService.dart';
import 'package:expense_tracker/utils/helpers.dart';
import 'package:expense_tracker/viewmodels/chartCategory.dart';
import 'package:flutter/cupertino.dart';

class ExpenseService {
  List<Expense> _expenseList = [];
  List<Expense> get expenseList {
    return _expenseList;
  }

  List<Expense> getExpenseByYearMonth({@required String yearMonth}) {
    final expenseLIst = _expenseList
        .where((element) => element.yearMonth == yearMonth)
        .toList();
    return expenseLIst;
  }

  int getTotalExpenseByYearMonth({@required String yearMonth}) {
    final currentExpenseList = _expenseList
        .where((element) => element.yearMonth == yearMonth)
        .toList();
    var totalSum = 0;
    currentExpenseList.forEach((element) {
      totalSum += element.amount;
    });
    return totalSum;
  }

  ResponseModel addExpense(Expense expense) {
    _expenseList.add(expense);
    return ResponseModel(isSucessfull: true, responseMessage: "expense Added");
  }

  Expense getExpense({@required String expenseId}) {
    final expense = _expenseList.firstWhere(
        (element) => element.id == expenseId,
        orElse: () =>
            Expense(id: "0", amount: 0, categoryId: "0", yearMonth: null));
    return expense;
  }

  List<ChartCategory> getExpenseChart(String yearMonth) {
    final currentExpenseList = _expenseList
        .where((element) => element.yearMonth == yearMonth)
        .toList();
    List<ChartCategory> _chartCategory = [];
    currentExpenseList.forEach((element) {
      final category = locator<CategoryService>()
          .getCategory(categoryId: element.categoryId);
      String categoryName = category.name;
      ChartCategory chCat = ChartCategory(
          itemId: element.id,
          category: categoryName,
          count: element.amount,
          yearMonth: element.yearMonth,
          chartColor: charts.ColorUtil.fromDartColor(
              Helpers.getChartColor(categoryName)));
      _chartCategory.add(chCat);
    });
    return _chartCategory;
  }
}
