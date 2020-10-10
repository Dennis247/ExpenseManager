import 'package:expense_tracker/Data/mockData.dart';
import 'package:expense_tracker/utils/appStyles.dart';
import 'package:expense_tracker/utils/constants.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class ExpenseHistoryWidget extends StatelessWidget {
  final String title;
  final String description;
  final String amount;
  final IconData iconData;
  final TextStyle textStyle;
  final Function function;

  const ExpenseHistoryWidget({
    Key key,
    @required this.title,
    @required this.description,
    @required this.amount,
    @required this.iconData,
    @required this.textStyle,
    @required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ListTile(
        onTap: function,
        leading: CircleAvatar(
          backgroundColor: Constants.primaryColorDark,
          child: Icon(
            iconData,
            color: Colors.white,
            size: 18,
          ),
        ),
        title: Text(
          title,
          style: AppTextStyles.appTextStyle,
        ),
        subtitle: Text(description, style: AppTextStyles.smallgreyTextStyle),
        trailing: Text(
          amount,
          style: textStyle,
        ),
      ),
    );
  }
}
