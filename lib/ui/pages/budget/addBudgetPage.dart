import 'package:expense_tracker/models/budget.dart';
import 'package:expense_tracker/services/budgetService.dart';
import 'package:expense_tracker/services/categoryService.dart';
import 'package:expense_tracker/ui/widgets/appButtonWidget.dart';
import 'package:expense_tracker/ui/widgets/appInputWidget.dart';
import 'package:expense_tracker/ui/widgets/appMonthYearWidget.dart';
import 'package:expense_tracker/ui/widgets/categoryListWIdget.dart';
import 'package:expense_tracker/ui/widgets/globalWidgets.dart';
import 'package:expense_tracker/utils/appStyles.dart';
import 'package:expense_tracker/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../../main.dart';
import 'budgetPage.dart';

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

  void _addExpesnse() {
    //check if form is valid
    bool isValid = _formKey.currentState.validate();
    if (!isValid) return;
    final selectedCategory = locator<CategoryService>().selectedCategory;
    int amount = Helpers.getFormattedAmount(_amountController.text);
    var expense = Budget(
        id: Uuid().v4(),
        categoryId: selectedCategory.id,
        amount: amount,
        yearMonth: _dateController.text);
    final response = locator<BudgetService>().addBudget(expense);
    if (response.isSucessfull) {
      GlobalWidgets.showSuccessDialogue("Budget Added Sucessfully", context,
          function: () {
        //go to expensePage
        Navigator.of(context).pushNamedAndRemoveUntil(
            BudgetPage.routeName, (Route<dynamic> route) => false);
      }, dismiss: false);
    }
  }

  @override
  void initState() {
    _dateController.text = Helpers.getFormattedDate(DateTime.now());
    super.initState();
  }

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
                          height: appSize.height * 0.08,
                        ),
                        AppButtonWudget(
                          width: appSize.width,
                          buttonText: "SUBMIT",
                          function: () {
                            _addExpesnse();
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
