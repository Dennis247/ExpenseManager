import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    if (category == "Shopping") {
      return Colors.orange;
    }

    return Colors.white;
  }
}
