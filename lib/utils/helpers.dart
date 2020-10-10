import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_multi_formatter/formatters/money_input_formatter.dart';
import 'package:intl/intl.dart';

class Helpers {
  static String stringValidator(String value, String controllerName) {
    if (value.isEmpty) {
      return "$controllerName cannot be empty";
    }
    return null;
  }

  static String getFormattedDate(DateTime datetime) {
    final DateFormat formatter = DateFormat('yyyy-MMM');
    String formattedDate = formatter.format(datetime);
    return formattedDate;
  }

  static Color generateRandomColors() {
    Random random = new Random();
    return Color.fromARGB(
        255, random.nextInt(255), random.nextInt(255), random.nextInt(255));
  }

  static int getFormattedAmount(String amount) {
    final amt = amount.replaceAll(new RegExp(r'N\s|\,'), "");
    return int.parse(amt);
  }

  static String getCurrencyString(int value) {
    return (value.toCurrencyString(
        leadingSymbol: "N", mantissaLength: 0, useSymbolPadding: true));
  }

  static Color getChartColor(String category) {
    if (category == "Food") {
      return Colors.green;
    }
    if (category == "Music") {
      return Colors.lime;
    }
    if (category == "School") {
      return Colors.red;
    }
    if (category == "Health") {
      return Colors.blue;
    }
    if (category == "Drinks") {
      return Colors.purple;
    }
    if (category == "Games") {
      return Colors.orange;
    }

    return Colors.white;
  }
}
