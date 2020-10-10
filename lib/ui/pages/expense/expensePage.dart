import 'package:expense_tracker/Data/mockData.dart';
import 'package:expense_tracker/main.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/services/expenseService.dart';
import 'package:expense_tracker/ui/pages/expense/addExpensePage.dart';
import 'package:expense_tracker/ui/pages/home/homePage.dart';
import 'package:expense_tracker/ui/widgets/appMonthYearWidget.dart';
import 'package:expense_tracker/ui/widgets/expenseCategoryChartWidget.dart';
import 'package:expense_tracker/ui/widgets/globalWidgets.dart';
import 'package:expense_tracker/utils/appStyles.dart';
import 'package:expense_tracker/utils/helpers.dart';
import 'package:expense_tracker/viewmodels/chartCategory.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpensePage extends StatefulWidget {
  static final routeName = "expense-page";

  @override
  _ExpensePageState createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  TextEditingController _dateControler = TextEditingController();
  List<Expense> _expenseList = [];
  @override
  void initState() {
    //set selected month & year to current month & year
    Provider.of<ChartCategroryProvider>(context, listen: false)
        .setSelectedMonthYear(Helpers.getFormattedDate(DateTime.now()), false);
    _dateControler.text = Helpers.getFormattedDate(DateTime.now());
    _getCurrentExpenseList();
    super.initState();
  }

  _getCurrentExpenseList() {
    _expenseList = locator<ExpenseService>().getExpenseByYearMonth(
        yearMonth: Helpers.getFormattedDate(DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    final appSize = GlobalWidgets.getAppSize(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "My Expense",
            style: AppTextStyles.appLightHeaderTextStyle,
          ),
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(HomePage.routeName);
              }),
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<ChartCategroryProvider>(
              builder: (context, chartData, _) {
                var totalExpense = locator<ExpenseService>()
                    .getTotalExpenseByYearMonth(
                        yearMonth: chartData.selectedMonthYear);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: appSize.width * 0.5,
                      child: AppYearMonthPicker(
                        controller: _dateControler,
                      ),
                    ),
                    SizedBox(
                      height: appSize.height * 0.12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Total Expense : ${Helpers.getCurrencyString(totalExpense)}",
                          style: AppTextStyles.appBlackigTextStyle,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: Container(
                          alignment: Alignment.center,
                          height: appSize.height * 0.4,
                          child: locator<ExpenseService>()
                                      .getExpenseChart(
                                          chartData.selectedMonthYear)
                                      .length ==
                                  0
                              ? Center(
                                  child: Text(
                                    "No Expense",
                                    style: AppTextStyles.appTextStyle,
                                  ),
                                )
                              : ExpenseCategortyChartWidget(
                                  expenseCategoryList: locator<ExpenseService>()
                                      .getExpenseChart(
                                          chartData.selectedMonthYear),
                                )),
                    )
                  ],
                );
              },
            )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AddExpensePage.routeName);
          },
          backgroundColor: Colors.pink,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
