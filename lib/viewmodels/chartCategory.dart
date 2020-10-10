import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class ChartCategory with ChangeNotifier {
  final String itemId;
  final int count;
  final String category;
  final String yearMonth;
  final charts.Color chartColor;

  ChartCategory(
      {@required this.itemId,
      @required this.count,
      @required this.category,
      @required this.yearMonth,
      @required this.chartColor});
}

class ChartCategroryProvider with ChangeNotifier {
  String _selectedMonthYear = "";
  String get selectedMonthYear {
    return _selectedMonthYear;
  }

  void notifyListenrer() {
    notifyListenrer();
  }

  void setSelectedMonthYear(String monthYear, bool notifyListener) {
    _selectedMonthYear = monthYear;
    if (notifyListener) notifyListeners();
  }
}
