import 'package:expense_tracker/Data/mockData.dart';
import 'package:expense_tracker/models/category.dart';
import 'package:flutter/cupertino.dart';

class CategoryService {
  Category _selectedCategory;
  Category get selectedCategory {
    return _selectedCategory;
  }

  void setSelectedCategory(Category cat) {
    _selectedCategory = cat;
  }

  Category getCategory({@required String categoryId}) {
    final category = MOckData.categoryLIst.firstWhere(
        (element) => element.id == categoryId,
        orElse: () => Category(id: "0", name: "No Category", iconData: null));
    return category;
  }

  List<Category> getCategoryList() {
    return MOckData.categoryLIst;
  }
}
