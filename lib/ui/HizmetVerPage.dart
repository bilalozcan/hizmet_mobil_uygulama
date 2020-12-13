import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hizmet_mobil_uygulama/models/Category.dart';

class HizmetVerPage extends StatefulWidget {
  @override
  _HizmetVerPageState createState() => _HizmetVerPageState();
}

class _HizmetVerPageState extends State<HizmetVerPage> {
  @override
  Widget build(BuildContext context) {
    veriOku();
    return Scaffold(
      appBar: AppBar(
        title: Text("Hizmet Ver page"),
      ),
      body: Column(
        children: [
          Text("List"),
          Text("List"),
          Text("List"),
          Text("List"),
          Text("List"),
          Text("List"),
        ],
      ),
    );
  }
  veriOku() async{
    var gelenJson = await DefaultAssetBundle.of(context).loadString("assets/Category.json");
    //debugPrint(gelenJson);

    LinkedHashMap<String, dynamic> map = json.decode(gelenJson.toString());
    Category category = Category.fromJson(map);
    for(var i in category.categoryList)
      debugPrint("KeyList: " + i);
    SubCategory subCategory = category.getSubCategory("Ders");
    for(var i in category.categoryList){
      debugPrint("Ders KeyList: " + i);
    }
    Data data = subCategory.getData("Diğer");
    for(var i in data.datas){
      debugPrint("Diğer List: " + i);
    }
  }
}
