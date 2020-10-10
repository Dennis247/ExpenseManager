import 'package:expense_tracker/main.dart';
import 'package:expense_tracker/models/budget.dart';
import 'package:expense_tracker/services/budgetService.dart';
import 'package:expense_tracker/ui/pages/budget/editBudget.dart';
import 'package:expense_tracker/viewmodels/chartCategory.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class BudgetCategortyChartWidget extends StatefulWidget {
  final List<ChartCategory> budgetCategoryList;

  const BudgetCategortyChartWidget({Key key, this.budgetCategoryList})
      : super(key: key);
  @override
  _BudgetCategortyChartWidgetState createState() =>
      _BudgetCategortyChartWidgetState();
}

class _BudgetCategortyChartWidgetState
    extends State<BudgetCategortyChartWidget> {
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
            id: 'budget report',
            domainFn: (ChartCategory budgetCategory, _) =>
                budgetCategory.category,
            measureFn: (ChartCategory budgetCategory, _) =>
                budgetCategory.count,
            colorFn: (ChartCategory budgetCategory, _) =>
                budgetCategory.chartColor,

            data: widget.budgetCategoryList,
            // Set a label accessor to control the text of the arc label.

            labelAccessorFn: (ChartCategory row, _) =>
                '${row.category}-${row.count}',
          )
        ],
        selectionModels: [
          new charts.SelectionModelConfig(
            type: charts.SelectionModelType.info,
            changedListener: (model) {
              var chartCategory = model.selectedDatum[0].datum as ChartCategory;
              final budget = locator<BudgetService>()
                  .getBudget(budgetId: chartCategory.itemId);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EditBudgetPage(
                        budget: budget,
                      )));

              //   final category =
              //go to edit budget
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
                  fontSize: 8,
                  color: charts.ColorUtil.fromDartColor(Colors.black)))
        ]));
  }

  /// Create one series with sample hard coded data.

}
