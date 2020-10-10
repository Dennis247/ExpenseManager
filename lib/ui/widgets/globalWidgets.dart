import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:expense_tracker/utils/appStyles.dart';
import 'package:expense_tracker/utils/constants.dart';
import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

class GlobalWidgets {
  static Size getAppSize(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return size;
  }

  static showFialureDialogue(String message, BuildContext context,
      {Function function, bool dismiss = true}) async {
    AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.TOPSLIDE,
        headerAnimationLoop: false,
        dismissOnTouchOutside: dismiss,
        //   title: 'Error',
        body: Column(
          children: <Widget>[
            Text(
              "Error",
              style: AppTextStyles.appDarkHeaderTextStyle,
            ),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.appTextStyle,
            )
          ],
        ),
        //  desc: message,
        btnOkOnPress: () {
          if (function != null) {
            function();
          }
        },
        btnOkIcon: Icons.cancel,
        btnOkColor: Constants.primaryColorDark)
      ..show();
  }

  static Widget circularInidcator() {
    return SpinKitWave(
      color: Constants.primaryColorDark,
      type: SpinKitWaveType.center,
    );
  }

  static showSuccessDialogue(String message, BuildContext context,
      {Function function, bool dismiss = true}) async {
    AwesomeDialog(
        context: context,
        dialogType: DialogType.SUCCES,
        animType: AnimType.TOPSLIDE,
        headerAnimationLoop: false,
        dismissOnTouchOutside: dismiss,
        // title: 'Error',
        body: Column(
          children: <Widget>[
            Text(
              "Sucess",
              style: AppTextStyles.appDarkHeaderTextStyle,
            ),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.appTextStyle,
            )
          ],
        ),
        //  desc: message,
        btnOkOnPress: () {
          if (function != null) {
            function();
          }
          //  Navigator.of(context).pop();
        },
        btnOkIcon: Icons.cancel,
        btnOkColor: Constants.primaryColorDark)
      ..show();
  }

  static showConfirmationDialogue(String message, BuildContext context,
      {Function function}) async {
    AwesomeDialog(
        context: context,
        dialogType: DialogType.WARNING,
        animType: AnimType.TOPSLIDE,
        headerAnimationLoop: true,

        // title: 'Error',
        body: Column(
          children: <Widget>[
            Text(
              "OK",
              style: AppTextStyles.appDarkHeaderTextStyle,
            ),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.appTextStyle,
            )
          ],
        ),
        //  desc: message,
        btnOkOnPress: () {
          if (function != null) {
            function();
          }
        },
        btnCancelIcon: Icons.cancel,
        btnCancelOnPress: () {},
        btnOkIcon: Icons.check,
        btnOkColor: Colors.green)
      ..show();
  }
}
