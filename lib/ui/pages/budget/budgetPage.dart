import 'package:expense_tracker/Data/mockData.dart';
import 'package:expense_tracker/ui/pages/budget/addBudgetPage.dart';
import 'package:expense_tracker/ui/widgets/appMonthYearWidget.dart';
import 'package:expense_tracker/ui/widgets/budgetCategoryChartWIdget.dart';
import 'package:expense_tracker/ui/widgets/expenseCategoryChartWidget.dart';
import 'package:expense_tracker/ui/widgets/globalWidgets.dart';
import 'package:expense_tracker/utils/appStyles.dart';
import 'package:expense_tracker/utils/constants.dart';
import 'package:expense_tracker/utils/helpers.dart';
import 'package:flutter/material.dart';

class BudgetPage extends StatefulWidget {
  static final routeName = "budget-page";
  @override
  _BudgetPageState createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  TextEditingController _dateControler = TextEditingController();
  @override
  void initState() {
    _dateControler.text = Helpers.getFormattedDate(DateTime.now());
    super.initState();
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
                Navigator.of(context).pop();
              }),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
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
                    "Total Budget : N 50, 000",
                    style: AppTextStyles.appBlackigTextStyle,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                    alignment: Alignment.center,
                    height: appSize.height * 0.4,
                    child: MOckData.expenseList.length == 0
                        ? Center(
                            child: Text(
                              "No Recent Budget",
                              style: AppTextStyles.appTextStyle,
                            ),
                          )
                        : BudgetCategortyChartWidget(
                            budgetCategoryList: MOckData.monthlyExpenseList,
                          )),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AddBudgetPage.routeName);
          },
          backgroundColor: Colors.blue,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
