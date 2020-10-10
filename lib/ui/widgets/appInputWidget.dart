import 'package:expense_tracker/utils/appStyles.dart';
import 'package:expense_tracker/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/money_input_formatter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class AppTextInputWIdget extends StatelessWidget {
  final String labelText;
  final IconData prefixIcon;
  final bool obscureText;
  final TextEditingController controller;
  final Function validator;
  final TextInputType keyboardType;
  final IconData suffixIcon;
  final Function suffixtap;

  const AppTextInputWIdget(
      {Key key,
      this.labelText,
      this.prefixIcon,
      this.obscureText,
      this.controller,
      this.validator,
      this.keyboardType,
      this.suffixIcon,
      this.suffixtap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: AppTextStyles.appInputTextStyle,
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      decoration: InputDecoration(
          labelText: labelText,
          labelStyle: AppTextStyles.labelTextStyle,
          prefixIcon: Icon(
            prefixIcon,
            color: Colors.grey,
          ),
          suffixIcon: GestureDetector(
            onTap: suffixtap,
            child: Icon(
              suffixIcon,
              color: Colors.grey,
            ),
          ),
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
      obscureText: obscureText,
    );
  }
}

class AppTextInputMultilineWIdget extends StatelessWidget {
  final String labelText;
  final IconData prefixIcon;
  final bool obscureText;
  final TextEditingController controller;
  final Function validator;

  const AppTextInputMultilineWIdget(
      {Key key,
      this.labelText,
      this.prefixIcon,
      this.obscureText,
      this.controller,
      this.validator})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: null,
      style: AppTextStyles.appInputTextStyle,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
          labelText: labelText,
          labelStyle: AppTextStyles.labelTextStyle,
          prefixIcon: Icon(
            prefixIcon,
            color: Constants.primaryColorDark,
          ),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Constants.primaryColorDark))),
      obscureText: obscureText,
    );
  }
}

class AppTextSmallInputWIdget extends StatelessWidget {
  final String labelText;
  final Widget prefixIcon;
  final bool obscureText;
  final Color prefixColor;
  final TextStyle labelTextSTyle;

  const AppTextSmallInputWIdget(
      {Key key,
      this.labelText,
      this.prefixIcon,
      this.obscureText,
      this.prefixColor,
      this.labelTextSTyle})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: AppTextStyles.appTextStyle,
      decoration: InputDecoration(
          labelText: labelText,
          labelStyle: labelTextSTyle,
          prefixIcon: prefixIcon,
          suffix: Icon(
            Icons.close,
            color: Constants.primaryColorDark,
            size: 15,
          ),
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
      obscureText: obscureText,
    );
  }
}

class AppDateInputController extends StatefulWidget {
  final TextEditingController dateController;
  final String date;
  final String labelText;
  final Icon prefixIcon;
  final Function validator;

  const AppDateInputController(
      {Key key,
      this.dateController,
      this.date,
      this.labelText,
      this.prefixIcon,
      this.validator})
      : super(key: key);

  @override
  _AppDateInputControllerState createState() => _AppDateInputControllerState();
}

class _AppDateInputControllerState extends State<AppDateInputController> {
  MaterialColor xxx = const MaterialColor(
    0xFF880E4F,
    const <int, Color>{
      50: const Color(0xFF880E4F),
      100: const Color(0xFF880E4F),
      200: const Color(0xFF880E4F),
      300: const Color(0xFF880E4F),
      400: const Color(0xFF880E4F),
      500: const Color(0xFF880E4F),
      600: const Color(0xFF880E4F),
      700: const Color(0xFF880E4F),
      800: const Color(0xFF880E4F),
      900: const Color(0xFF880E4F),
    },
  );

  _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime(1990, 1, 1),
      firstDate: DateTime(1800, 1, 1),
      lastDate: DateTime.now(),
      initialDatePickerMode: DatePickerMode.year,
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData(
            primaryColor: Constants.primaryColorDark,
            accentColor: Constants.primaryColorLight,
            primarySwatch: xxx,
            buttonBarTheme: ButtonBarThemeData(
              buttonTextTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child,
        );
      },
    );
    if (date != null) {
      var formatter = new DateFormat('dd/MM/yyyy');
      widget.dateController.text = formatter.format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      onTap: _selectDate,
      controller: widget.dateController,
      validator: widget.validator,
      style: AppTextStyles.appTextStyle,
      decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: AppTextStyles.labelTextStyle,
          hintStyle: AppTextStyles.greyTextStyle,
          prefixIcon: widget.prefixIcon,
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
    );
  }
}

class AppAmountInputWIdget extends StatelessWidget {
  final TextEditingController controller;
  final Function validator;
  final String labelText;
  final Function onChangedFunction;

  const AppAmountInputWIdget(
      {Key key,
      this.controller,
      this.validator,
      this.labelText,
      this.onChangedFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      style: AppTextStyles.appInputTextStyle,
      controller: controller,
      onChanged: (String value) {
        onChangedFunction(value);
      },
      validator: validator,
      decoration: InputDecoration(
          labelText: labelText,
          labelStyle: AppTextStyles.labelTextStyle,
          prefixIcon: Icon(
            FontAwesomeIcons.moneyBill,
            color: Colors.grey,
          )),
      inputFormatters: [
        MoneyInputFormatter(
            useSymbolPadding: true, leadingSymbol: "N", mantissaLength: 0)
      ],
    );
  }
}

class AppTextInputPhoneWIdget extends StatelessWidget {
  final String labelText;
  final IconData suffixIcon;
  final bool obscureText;
  final TextEditingController controller;
  final Function validator;
  final TextInputType keyboardType;
  final Function function;
  final Function phoneValidator;

  const AppTextInputPhoneWIdget(
      {Key key,
      this.labelText,
      this.suffixIcon,
      this.obscureText,
      this.controller,
      this.validator,
      this.keyboardType,
      this.function,
      this.phoneValidator})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: AppTextStyles.appInputTextStyle,
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      onChanged: (String value) {
        phoneValidator(value);
      },
      decoration: InputDecoration(
          labelText: labelText,
          hintText: "080...",
          hintStyle: AppTextStyles.greyTextStyle,
          labelStyle: AppTextStyles.labelTextStyle,
          suffixIcon: IconButton(
              iconSize: 30,
              icon: Icon(
                FontAwesomeIcons.addressCard,
                color: Constants.primaryColorDark,
              ),
              onPressed: function),
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
      obscureText: obscureText,
    );
  }
}
