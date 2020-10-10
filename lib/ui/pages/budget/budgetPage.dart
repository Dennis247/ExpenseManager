import 'package:expense_tracker/models/budget.dart';
import 'package:expense_tracker/services/budgetService.dart';
import 'package:expense_tracker/ui/pages/home/homePage.dart';
import 'package:expense_tracker/ui/widgets/appMonthYearWidget.dart';
import 'package:expense_tracker/ui/widgets/budgetCategoryChartWIdget.dart';
import 'package:expense_tracker/ui/widgets/globalWidgets.dart';
import 'package:expense_tracker/utils/appStyles.dart';
import 'package:expense_tracker/utils/helpers.dart';
import 'package:expense_tracker/viewmodels/chartCategory.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';
import 'addBudgetPage.dart';

class BudgetPage extends StatefulWidget {
  static final routeName = "budget-page";
  @override
  _BudgetPageState createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  TextEditingController _dateControler = TextEditingController();
  List<Budget> _budgetList = [];
  @override
  void initState() {
    //set selected month & year to current month & year
    Provider.of<ChartCategroryProvider>(context, listen: false)
        .setSelectedMonthYear(Helpers.getFormattedDate(DateTime.now()), false);
    _dateControler.text = Helpers.getFormattedDate(DateTime.now());
    _getCurrentBudgetList();
    super.initState();
  }

  _getCurrentBudgetList() {
    _budgetList = locator<BudgetService>().getBudgetByYearMonth(
        yearMonth: Helpers.getFormattedDate(DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    final appSize = GlobalWidgets.getAppSize(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "My Budget",
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
                var totalBudget = locator<BudgetService>()
                    .getTotalBudgetByYearMonth(
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
                          "Total Budget :  ${Helpers.getCurrencyString(totalBudget)}",
                          style: AppTextStyles.appBlackigTextStyle,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Container(
                          alignment: Alignment.center,
                          height: appSize.height * 0.4,
                          child: locator<BudgetService>()
                                      .getBudgetChart(
                                          chartData.selectedMonthYear)
                                      .length ==
                                  0
                              ? Center(
                                  child: Text(
                                    "No Budget",
                                    style: AppTextStyles.appTextStyle,
                                  ),
                                )
                              : BudgetCategortyChartWidget(
                                  budgetCategoryList: locator<BudgetService>()
                                      .getBudgetChart(
                                          chartData.selectedMonthYear),
                                )),
                    )
                  ],
                );
              },
            )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AddBudgetPage.routeName);
          },
          backgroundColor: Colors.pink,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
