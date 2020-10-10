import 'package:expense_tracker/services/budgetService.dart';
import 'package:expense_tracker/services/categoryService.dart';
import 'package:expense_tracker/services/expenseService.dart';
import 'package:expense_tracker/ui/pages/budget/addBudgetPage.dart';
import 'package:expense_tracker/ui/pages/expense/addExpensePage.dart';
import 'package:expense_tracker/ui/pages/expense/expensePage.dart';
import 'package:expense_tracker/utils/constants.dart';
import 'package:expense_tracker/viewmodels/chartCategory.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'ui/pages/budget/budgetPage.dart';
import 'ui/pages/home/homePage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  setupLocator();
  runApp(MyApp());
}

final locator = GetIt.instance;
void setupLocator() {
  locator.registerSingleton(CategoryService());
  locator.registerSingleton(BudgetService());
  locator.registerSingleton(ExpenseService());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ChartCategroryProvider()),
      ],
      child: MaterialApp(
        title: 'Expense Tracker',
        theme: ThemeData(
          primaryColor: Constants.primaryColorDark,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(),
        routes: {
          HomePage.routeName: (context) => HomePage(),
          ExpensePage.routeName: (context) => ExpensePage(),
          AddExpensePage.routeName: (context) => AddExpensePage(),
          BudgetPage.routeName: (context) => BudgetPage(),
          AddBudgetPage.routeName: (context) => AddBudgetPage()
        },
      ),
    );
  }
}
