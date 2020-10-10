import 'package:expense_tracker/models/budget.dart';
import 'package:expense_tracker/models/response.dart';
import 'package:expense_tracker/services/categoryService.dart';
import 'package:expense_tracker/utils/helpers.dart';
import 'package:expense_tracker/viewmodels/chartCategory.dart';
import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../main.dart';

class BudgetService {
  List<Budget> _budgetList = [];
  List<Budget> get budgetList {
    return _budgetList;
  }

  List<Budget> getBudgetByYearMonth({@required String yearMonth}) {
    final budgetLIst =
        _budgetList.where((element) => element.yearMonth == yearMonth).toList();
    return budgetLIst;
  }

  int getTotalBudgetByYearMonth({@required String yearMonth}) {
    final currentBudgetList =
        _budgetList.where((element) => element.yearMonth == yearMonth).toList();
    var totalSum = 0;
    currentBudgetList.forEach((element) {
      totalSum += element.amount;
    });
    return totalSum;
  }

  ResponseModel addBudget(Budget budget) {
    _budgetList.add(budget);
    return ResponseModel(isSucessfull: true, responseMessage: "budget Added");
  }

  Budget getBudget({@required String budgetId}) {
    final budget = _budgetList.firstWhere((element) => element.id == budgetId,
        orElse: () =>
            Budget(id: "0", amount: 0, categoryId: "0", yearMonth: null));
    return budget;
  }

  List<ChartCategory> getBudgetChart(String yearMonth) {
    final currentBudgetList =
        _budgetList.where((element) => element.yearMonth == yearMonth).toList();
    List<ChartCategory> _chartCategory = [];
    currentBudgetList.forEach((element) {
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
