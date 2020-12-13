import 'dart:collection';
import 'package:flutter/material.dart';

class Category {
  LinkedHashMap<String, dynamic> categories;
  List<String> categoryList;

  Category({@required this.categories}) {
    categoryList = List<String>();
    for (String key in categories.keys) categoryList.add(key);
  }

  factory Category.fromJson(LinkedHashMap<String, dynamic> parsedJson) {
    return Category(categories: parsedJson);
  }
  List<DropdownMenuItem<String>> CategoryDropdownMenuItemList(){
    List<DropdownMenuItem<String>> _categoryDropDownMenuItemList = List<DropdownMenuItem<String>>();
    for (String key in categoryList) {
      _categoryDropDownMenuItemList.add(DropdownMenuItem<String>(
        child: Text(key),
        value: key,
      ));
    }
    return _categoryDropDownMenuItemList;
  }

  SubCategory getSubCategory(String key) {
    debugPrint("getSubCategory: " + key);
    return SubCategory.fromJson(categories[key]);
  }

}

class SubCategory {
  LinkedHashMap<String, dynamic> subCategories;
  List<String> subCategoryList;

  SubCategory({@required this.subCategories}) {
    subCategoryList = List<String>();
    for (String key in subCategories.keys) subCategoryList.add(key);
  }

  factory SubCategory.fromJson(LinkedHashMap<String, dynamic> parsedJson) {
    return SubCategory(subCategories: parsedJson);
  }

  Data getData(String key) {
    return Data(datas: subCategories[key]);
  }
  List<DropdownMenuItem<String>> SubCategoryDropdownMenuItemList(String key){
    List<DropdownMenuItem<String>> _subCategoryDropDownMenuItemList = List<DropdownMenuItem<String>>();
    for (String key in subCategoryList) {
      _subCategoryDropDownMenuItemList.add(DropdownMenuItem<String>(
        child: Text(key),
        value: key,
      ));
    }
    return _subCategoryDropDownMenuItemList;
  }
}

class Data {
  List<dynamic> datas;

  Data({@required this.datas});

  List<String> getData() {
    return datas;
  }
}
