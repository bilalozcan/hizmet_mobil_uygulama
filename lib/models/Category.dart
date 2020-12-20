import 'dart:collection';
import 'package:flutter/material.dart';

class Category {
  LinkedHashMap<String, dynamic> categories;
  List<String> categoryList;

  Category({@required this.categories}) {
    categoryList = [];
    for (String key in categories.keys) categoryList.add(key);
  }

  factory Category.fromJson(LinkedHashMap<String, dynamic> parsedJson) {
    return Category(categories: parsedJson);
  }

  SubCategory getSubCategory(String key) {
    return SubCategory.fromJson(categories[key]);
  }

}

class SubCategory {
  LinkedHashMap<String, dynamic> subCategories;
  List<String> subCategoryList;

  SubCategory({@required this.subCategories}) {
    subCategoryList = [];
    for (String key in subCategories.keys) subCategoryList.add(key);
  }

  factory SubCategory.fromJson(LinkedHashMap<String, dynamic> parsedJson) {
    return SubCategory(subCategories: parsedJson);
  }

  List<dynamic> getData(String key) {
    //debugPrint(subCategories[key]);
    List<dynamic> dataList = [];
    debugPrint(subCategories[key].runtimeType.toString());
    for(var i in subCategories[key]){
      debugPrint(i.toString());
      dataList.add(i);
    }
    return dataList;

    //return Data.fromJson(subCategories[key]);
    //return Data(datas: subCategories[key]);
  }
}

class Data {
  List<dynamic> data;
  List<dynamic> datas;

  Data({@required this.data}){
    datas = [];
    for (var i in data){
      datas.add(i);
    }
  }
  factory Data.fromJson(List<dynamic> data){
    return Data(data: data);
  }
  List<dynamic> getData() {
    return datas;
  }
}
