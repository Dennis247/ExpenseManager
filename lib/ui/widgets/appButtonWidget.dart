import 'package:expense_tracker/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'globalWidgets.dart';

class AppButtonWudget extends StatelessWidget {
  final String buttonText;
  final Function function;
  final Color color;
  final double width;

  const AppButtonWudget(
      {Key key, this.buttonText, this.function, this.color, this.width})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final appSzie = GlobalWidgets.getAppSize(context);
    return GestureDetector(
      onTap: function,
      child: Container(
        alignment: Alignment.center,
        child: Text(
          buttonText,
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: Constants.primaryColorLight,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        width: width != null ? width : appSzie.width * 0.8,
        height: 48.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: color == null ? Constants.primaryColorDark : color,
        ),
      ),
    );
  }
}
