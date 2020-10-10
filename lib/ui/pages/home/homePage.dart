import 'package:expense_tracker/Data/mockData.dart';
import 'package:expense_tracker/services/categoryService.dart';
import 'package:expense_tracker/services/expenseService.dart';
import 'package:expense_tracker/ui/pages/budget/budgetPage.dart';
import 'package:expense_tracker/ui/pages/expense/addExpensePage.dart';
import 'package:expense_tracker/ui/pages/expense/expensePage.dart';
import 'package:expense_tracker/ui/widgets/expenseCategoryChartWidget.dart';
import 'package:expense_tracker/ui/widgets/expenseHistoryWidget.dart';
import 'package:expense_tracker/ui/widgets/globalWidgets.dart';
import 'package:expense_tracker/utils/appStyles.dart';
import 'package:expense_tracker/utils/constants.dart';
import 'package:expense_tracker/utils/helpers.dart';
import 'package:expense_tracker/viewmodels/chartCategory.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
//import 'package:time_ago_provider/time_ago_provider.dart' as timeAgo;

import '../../../main.dart';

class HomePage extends StatefulWidget {
  static final String routeName = "HomePage";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Provider.of<ChartCategroryProvider>(context, listen: false)
        .setSelectedMonthYear(Helpers.getFormattedDate(DateTime.now()), false);
    super.initState();
  }

  _buildActionWIdgets({
    @required IconData iconData,
    @required String title,
    @required Function function,
    @required Size appSize,
    @required Color color,
  }) {
    return GestureDetector(
      onTap: function,
      child: Column(
        children: <Widget>[
          Container(
            width: appSize.width * 0.15,
            height: appSize.height * 0.08,
            child: Icon(
              iconData,
              color: Colors.white,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: color,
                boxShadow: [
                  BoxShadow(color: Constants.backGroundColor2, spreadRadius: 1)
                ]),
          ),
          SizedBox(
            height: appSize.height * 0.01,
          ),
          Text(
            title,
            style: AppTextStyles.smallerblackTextStyle,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appSize = GlobalWidgets.getAppSize(context);
    final currentExpesne = locator<ExpenseService>().getTotalExpenseByYearMonth(
        yearMonth: Helpers.getFormattedDate(DateTime.now()));
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Constants.backGroundColor,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Constants.primaryColorDark,
          elevation: 0,
          title: Text(
            "Expense Manager",
            style: AppTextStyles.appLightHeaderTextStyle,
          ),
          // Image.asset('assets/images/onboarding/$assetName.png'),
          automaticallyImplyLeading: false,
          leading: IconButton(
              icon: Icon(
                Icons.menu,
                color: Constants.primaryColorLight,
              ),
              onPressed: () {
                _scaffoldKey.currentState.openDrawer();
              }),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  FontAwesomeIcons.bell,
                  color: Constants.primaryColorLight,
                ),
                onPressed: () {
                  _scaffoldKey.currentState.openDrawer();
                }),
          ],
        ),
        drawer: Drawer(),
        body: Container(
            height: appSize.height,
            width: appSize.width,
            child: SingleChildScrollView(
              child: Stack(
                children: <Widget>[
                  Container(
                    height: appSize.height * 0.18,
                    width: appSize.width,
                    color: Constants.primaryColorDark,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          elevation: 2,
                          child: Container(
                              height: appSize.height * 0.325,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 12, right: 12, top: 20),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "Expense",
                                              style: AppTextStyles
                                                  .smallblackTextStyle,
                                            ),
                                            Text(
                                              ("N $currentExpesne"),
                                              style: AppTextStyles
                                                  .appPrimaryColorHeaderTextStyle,
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "Budget",
                                              style: AppTextStyles
                                                  .smallblackTextStyle,
                                            ),
                                            Text(
                                              ("N 10,000"),
                                              style: AppTextStyles
                                                  .appGreenHeaderTextStyle,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: appSize.height * 0.012,
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                    ),
                                    Container(
                                      width: appSize.width,
                                      height: appSize.height * 0.15,
                                      child: GridView.count(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        crossAxisSpacing: 0,
                                        padding: EdgeInsets.all(8),
                                        crossAxisCount: 3,
                                        mainAxisSpacing: 0,
                                        children: <Widget>[
                                          _buildActionWIdgets(
                                              appSize: appSize,
                                              function: () {
                                                Navigator.of(context).pushNamed(
                                                    ExpensePage.routeName);
                                              },
                                              title: "Expense",
                                              iconData: FontAwesomeIcons.wallet,
                                              color:
                                                  Constants.primaryColorDark),
                                          _buildActionWIdgets(
                                              appSize: appSize,
                                              function: () {
                                                Navigator.of(context).pushNamed(
                                                    BudgetPage.routeName);
                                              },
                                              title: "Budget",
                                              iconData: FontAwesomeIcons
                                                  .moneyCheckAlt,
                                              color: Colors.blue),
                                          _buildActionWIdgets(
                                              appSize: appSize,
                                              function: () {},
                                              title: "Category",
                                              iconData:
                                                  FontAwesomeIcons.landmark,
                                              color: Colors.deepPurple),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                        SizedBox(
                          height: appSize.height * 0.035,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Recent Expenses",
                              style: AppTextStyles.appBlackigTextStyle,
                            ),
                          ],
                        ),
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Consumer<ChartCategroryProvider>(
                                builder: (context, chartData, _) {
                                  return Container(
                                      alignment: Alignment.center,
                                      height: appSize.height * 0.4,
                                      child: locator<ExpenseService>()
                                                  .getExpenseChart(chartData
                                                      .selectedMonthYear)
                                                  .length ==
                                              0
                                          ? Center(
                                              child: Text(
                                                "No Recent Expense",
                                                style:
                                                    AppTextStyles.appTextStyle,
                                              ),
                                            )
                                          : ExpenseCategortyChartWidget(
                                              expenseCategoryList:
                                                  locator<ExpenseService>()
                                                      .getExpenseChart(chartData
                                                          .selectedMonthYear),
                                            ));
                                },
                              )),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
