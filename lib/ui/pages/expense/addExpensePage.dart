import 'package:expense_tracker/main.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/services/categoryService.dart';
import 'package:expense_tracker/services/expenseService.dart';
import 'package:expense_tracker/ui/pages/expense/expensePage.dart';
import 'package:expense_tracker/ui/pages/home/homePage.dart';
import 'package:expense_tracker/ui/widgets/appButtonWidget.dart';
import 'package:expense_tracker/ui/widgets/appInputWidget.dart';
import 'package:expense_tracker/ui/widgets/appMonthYearWidget.dart';
import 'package:expense_tracker/ui/widgets/categoryListWIdget.dart';
import 'package:expense_tracker/ui/widgets/globalWidgets.dart';
import 'package:expense_tracker/utils/appStyles.dart';
import 'package:expense_tracker/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AddExpensePage extends StatefulWidget {
  static final routeName = "add-expense-page";
  @override
  _AddExpensePageState createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
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
    var expense = Expense(
        id: Uuid().v4(),
        categoryId: selectedCategory.id,
        amount: amount,
        yearMonth: _dateController.text);
    final response = locator<ExpenseService>().addExpense(expense);
    if (response.isSucessfull) {
      GlobalWidgets.showSuccessDialogue("Expense Added Sucessfully", context,
          function: () {
        //go to expensePage
        Navigator.of(context).pushNamedAndRemoveUntil(
            ExpensePage.routeName, (Route<dynamic> route) => false);
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
            "Add Expense",
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
