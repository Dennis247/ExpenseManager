import 'package:expense_tracker/services/expenseService.dart';
import 'package:expense_tracker/ui/pages/expense/editExpense.dart';
import 'package:expense_tracker/utils/helpers.dart';
import 'package:expense_tracker/viewmodels/chartCategory.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../../main.dart';

class ExpenseCategortyChartWidget extends StatefulWidget {
  final List<ChartCategory> expenseCategoryList;

  const ExpenseCategortyChartWidget({Key key, this.expenseCategoryList})
      : super(key: key);
  @override
  _ExpenseCategortyChartWidgetState createState() =>
      _ExpenseCategortyChartWidgetState();
}

class _ExpenseCategortyChartWidgetState
    extends State<ExpenseCategortyChartWidget> {
  List<charts.Series> seriesList;
  bool animate = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(
        seriesList = [
          new charts.Series<ChartCategory, String>(
            id: 'expense report',
            domainFn: (ChartCategory expenseCategory, _) =>
                expenseCategory.category,
            measureFn: (ChartCategory expenseCategory, _) =>
                expenseCategory.count,
            colorFn: (ChartCategory expenseCategory, _) =>
                expenseCategory.chartColor,

            data: widget.expenseCategoryList,
            // Set a label accessor to control the text of the arc label.

            labelAccessorFn: (ChartCategory row, _) =>
                '${row.category}-${Helpers.getCurrencyString(row.count)}',
          )
        ],
        selectionModels: [
          new charts.SelectionModelConfig(
            type: charts.SelectionModelType.info,
            changedListener: (model) {
              var chartCategory = model.selectedDatum[0].datum as ChartCategory;
              final expense = locator<ExpenseService>()
                  .getExpense(expenseId: chartCategory.itemId);

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EditExpense(
                        expense: expense,
                      )));
            },
          )
        ],
        animate: animate,
        defaultRenderer:
            new charts.ArcRendererConfig(arcWidth: 50, arcRendererDecorators: [
          new charts.ArcLabelDecorator(
              showLeaderLines: false,
              labelPosition: charts.ArcLabelPosition.outside,
              labelPadding: 0,
              outsideLabelStyleSpec: new charts.TextStyleSpec(
                  fontSize: 10,
                  color: charts.ColorUtil.fromDartColor(Colors.black)))
        ]));
  }

  /// Create one series with sample hard coded data.

}
