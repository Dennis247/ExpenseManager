import 'package:expense_tracker/Data/mockData.dart';
import 'package:expense_tracker/models/budget.dart';
import 'package:flutter/cupertino.dart';

class BudgetService {
  Budget getBudget({@required String budgetId}) {
    final budget = MOckData.budgetlist.firstWhere(
        (element) => element.id == budgetId,
        orElse: () =>
            Budget(id: "0", amount: 0, categoryId: "0", yearMonth: null));
    return budget;
  }
}
