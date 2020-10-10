import 'package:expense_tracker/ui/widgets/appButtonWidget.dart';
import 'package:expense_tracker/ui/widgets/appInputWidget.dart';
import 'package:expense_tracker/ui/widgets/appMonthYearWidget.dart';
import 'package:expense_tracker/ui/widgets/categoryListWIdget.dart';
import 'package:expense_tracker/ui/widgets/globalWidgets.dart';
import 'package:expense_tracker/utils/appStyles.dart';
import 'package:expense_tracker/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class AddBudgetPage extends StatefulWidget {
  static final routeName = "add-budget-page";
  @override
  _AddBudgetPageState createState() => _AddBudgetPageState();
}

class _AddBudgetPageState extends State<AddBudgetPage> {
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  TextEditingController _dateController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final appSize = GlobalWidgets.getAppSize(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Add Budget",
            style: AppTextStyles.appLightHeaderTextStyle,
          ),
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: appSize.width,
            height: appSize.height,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: SingleChildScrollView(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        AppAmountInputWIdget(
                          labelText: "amount",
                          controller: _amountController,
                          validator: (String value) {
                            return Helpers.stringValidator(value, 'amount');
                          },
                        ),
                        SizedBox(
                          height: appSize.height * 0.035,
                        ),
                        CategoryListWidget(
                          controller: _categoryController,
                        ),
                        SizedBox(
                          height: appSize.height * 0.035,
                        ),
                        AppYearMonthPicker(
                          controller: _dateController,
                        ),
                        SizedBox(
                          height: appSize.height * 0.1,
                        ),
                        AppButtonWudget(
                          width: appSize.width,
                          buttonText: "SUBMIT",
                          function: () {
                            bool isValid = _formKey.currentState.validate();
                            if (!isValid) return;
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (context) =>
                            //         ConfirmElectricityPaymentPage(
                            //           amount: _amountController.text,
                            //           accountno:
                            //               _accountNumberController.text,
                            //           disco: _discoController.text,
                            //           paymenttype:
                            //               _selectedPaymentTypeController.text,
                            //         )));
                          },
                        ),
                        SizedBox(
                          height: appSize.height * 0.05,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
