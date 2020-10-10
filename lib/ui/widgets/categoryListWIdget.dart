import 'package:expense_tracker/models/category.dart';
import 'package:expense_tracker/services/categoryService.dart';
import 'package:expense_tracker/ui/widgets/globalWidgets.dart';
import 'package:expense_tracker/utils/appStyles.dart';
import 'package:expense_tracker/utils/constants.dart';
import 'package:expense_tracker/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../main.dart';

class CategoryListWidget extends StatefulWidget {
  final TextEditingController controller;

  const CategoryListWidget({Key key, this.controller}) : super(key: key);
  @override
  _CategoryListWidgetState createState() => _CategoryListWidgetState();
}

class _CategoryListWidgetState extends State<CategoryListWidget> {
  List<Category> _categoryList = [];
  @override
  void initState() {
    _categoryList = locator<CategoryService>().getCategoryList();
    super.initState();
  }

  _showCategoryList(Size appSize) {
    return showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Container(
                width: appSize.width,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          width: appSize.width,
                          height: appSize.height * 0.09,
                          child: Center(
                            child: Text("select category",
                                style: AppTextStyles.appLightHeaderTextStyle),
                          ),
                          decoration: new BoxDecoration(
                              color: Constants.primaryColorDark,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0)))),
                      Container(
                        width: appSize.width,
                        height: appSize.height * 0.65,
                        child: _categoryList.length == 0
                            ? Center(
                                child: Text(
                                  "category list is empty",
                                  style: AppTextStyles.appTextStyle,
                                ),
                              )
                            : ListView.builder(
                                itemCount: _categoryList.length,
                                itemBuilder: (context, index) {
                                  Category category = _categoryList[index];
                                  return GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () {
                                      locator<CategoryService>()
                                          .setSelectedCategory(category);
                                      Navigator.of(context).pop();
                                      setState(() {
                                        widget.controller.text = category.name;
                                      });
                                    },
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Row(
                                          children: <Widget>[
                                            Icon(
                                              category.iconData,
                                              color: Constants.primaryColorDark,
                                              size: appSize.width * 0.065,
                                            ),
                                            SizedBox(
                                              width: appSize.width * 0.03,
                                            ),
                                            Text(
                                              category.name,
                                              style: AppTextStyles.appTextStyle,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                      )
                    ],
                  ),
                ),
                height: appSize.height * 0.8,
                decoration: new BoxDecoration(
                    color: Color(0xffffffff),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0))),
              );
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final appSize = GlobalWidgets.getAppSize(context);
    return TextFormField(
      style: AppTextStyles.appTextStyle,
      controller: widget.controller,
      readOnly: true,
      onTap: () {
        _showCategoryList(appSize);
      },
      keyboardType: TextInputType.text,
      validator: (String value) {
        return Helpers.stringValidator(value, "category");
      },
      decoration: InputDecoration(
          labelText: "category",
          labelStyle: AppTextStyles.labelTextStyle,
          prefixIcon: Icon(
            FontAwesomeIcons.list,
            color: Colors.grey,
          ),
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
      obscureText: false,
    );
  }
}
