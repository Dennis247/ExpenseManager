import 'package:expense_tracker/main.dart';
import 'package:expense_tracker/services/categoryService.dart';
import 'package:expense_tracker/services/expenseService.dart';
import 'package:expense_tracker/utils/appStyles.dart';
import 'package:expense_tracker/utils/constants.dart';
import 'package:expense_tracker/utils/helpers.dart';
import 'package:expense_tracker/viewmodels/chartCategory.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:provider/provider.dart';

class AppYearMonthPicker extends StatefulWidget {
  final TextEditingController controller;

  const AppYearMonthPicker({Key key, this.controller}) : super(key: key);
  @override
  _AppYearMonthPickerState createState() => _AppYearMonthPickerState();
}

class _AppYearMonthPickerState extends State<AppYearMonthPicker> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: AppTextStyles.appTextStyle,
      controller: widget.controller,
      readOnly: true,
      onTap: () {
        showMonthPicker(
          context: context,
          firstDate: DateTime(DateTime.now().year - 1, 5),
          lastDate: DateTime(DateTime.now().year + 1, 9),
          initialDate: DateTime(DateTime.now().year, DateTime.now().month),
          locale: Locale("en"),
        ).then((date) {
          if (date != null) {
            setState(() {
              widget.controller.text = Helpers.getFormattedDate(date);
              //todo set selected date
              Provider.of<ChartCategroryProvider>(context, listen: false)
                  .setSelectedMonthYear(widget.controller.text, true);
            });
          }
        });
      },
      keyboardType: TextInputType.text,
      validator: (String value) {
        return Helpers.stringValidator(value, "year-month");
      },
      decoration: InputDecoration(
          labelText: "year - month",
          labelStyle: AppTextStyles.labelTextStyle,
          prefixIcon: Icon(
            FontAwesomeIcons.calendar,
            color: Colors.grey,
          ),
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
      obscureText: false,
    );
  }
}
