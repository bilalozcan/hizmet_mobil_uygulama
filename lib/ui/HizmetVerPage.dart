import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hizmet_mobil_uygulama/models/Category.dart';
import 'package:hizmet_mobil_uygulama/models/Hizmet.dart';
import 'package:hizmet_mobil_uygulama/viewmodel/hizmet_model.dart';
import 'package:hizmet_mobil_uygulama/viewmodel/user_model.dart';
import 'package:provider/provider.dart';

class HizmetVerPage extends StatefulWidget {
  Category _category;

  HizmetVerPage(this._category);

  @override
  _HizmetVerPageState createState() => _HizmetVerPageState(_category);
}

class _HizmetVerPageState extends State<HizmetVerPage> {
  List<DropdownMenuItem<String>> _categoryDropDownMenuItemList;
  List<DropdownMenuItem<String>> _subCategoryDropDownMenuItemList;
  Category _category;
  String CategoryCurrentValue = null;
  String SubCategoryCurrentValue = null;

  _HizmetVerPageState(this._category);

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _categoryDropDownMenuItemList = List<DropdownMenuItem<String>>();
    _subCategoryDropDownMenuItemList = List<DropdownMenuItem<String>>();
    connectJson();
    _categoryDropDownMenuItemList = _category.CategoryDropdownMenuItemList();
    setState(() {
      _categoryDropDownMenuItemList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hizmet Ver page"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final _userModel = Provider.of<UserModel>(context, listen: false);
          final _hizmetModel = Provider.of<HizmetModel>(context, listen: false);
          Hizmet _olusturulanHizmet = await _hizmetModel.createHizmet(
              hizmetID: "65456321231fsdfsa",
              title: "Bana Bir Mobil Uygulam Lazım",
              category: "Kurumsal",
              subCategory: "Mobil Uygulama",
              publisher: "USERID",
              detail: "Açıklam 123456",
              address: "Çırpıcı",
              payment: 1000.0);
          debugPrint(_olusturulanHizmet.toString());
        },

      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 45,
          ),
          Padding(
            padding: EdgeInsets.only(left: 150),
            child: DropdownButton<String>(
              hint: Text("Kategori Seçiniz"),
              value: CategoryCurrentValue,
              iconEnabledColor: Colors.black54,
              dropdownColor: Colors.blue,
              iconDisabledColor: Colors.black54,
              focusColor: Colors.black54,
              style:
                  TextStyle(color: Colors.black, decorationColor: Colors.black),
              items: _categoryDropDownMenuItemList,
              onChanged: (gelen) {
                debugPrint(gelen);
                CategoryCurrentValue = gelen;
                _subCategoryDropDownMenuItemList = _category
                    .getSubCategory(gelen)
                    .SubCategoryDropdownMenuItemList(gelen);
                setState(() {
                  CategoryCurrentValue;
                  SubCategoryCurrentValue =
                      _subCategoryDropDownMenuItemList.elementAt(0).value;
                });
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 150),
            child: DropdownButton<String>(
              hint: Text("Alt Kategori Seçiniz"),
              value: SubCategoryCurrentValue,
              iconEnabledColor: Colors.black54,
              dropdownColor: Colors.blue,
              iconDisabledColor: Colors.black54,
              focusColor: Colors.black54,
              style:
                  TextStyle(color: Colors.black, decorationColor: Colors.black),
              items: _subCategoryDropDownMenuItemList,
              onChanged: (gelen) {
                debugPrint(gelen);
                SubCategoryCurrentValue = gelen;
                setState(() {
                  SubCategoryCurrentValue;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  /*void subCategoryPull(String key) {
    debugPrint("subCategoryPull: " + key);
    _subCategoryDropDownMenuItemList.clear();
    debugPrint(category.toString());
    SubCategory subCategory = category.getSubCategory(key);
    for (String key in subCategory.subCategoryList) {
      debugPrint("SubCategory Deger: " + key);
      _subCategoryDropDownMenuItemList.add(DropdownMenuItem<String>(
        child: Text(key),
        value: key,
      ));
    }
    setState(() {
      _subCategoryDropDownMenuItemList;
    });
  }*/

  void connectJson() {
    DefaultAssetBundle.of(context)
        .loadString("assets/Category.json")
        .then((gelenJson) {
      LinkedHashMap<String, dynamic> map = json.decode(gelenJson.toString());
      _category = Category.fromJson(map);
    }).catchError((onError) => print(onError));
  }

/*Future<LinkedHashMap<String, dynamic>> connectJson() async {
    var gelenJson =
        await DefaultAssetBundle.of(context).loadString("assets/Category.json");
    var map = await json.decode(gelenJson.toString());
    debugPrint("TYPE: " + map.runtimeType.toString());
    return map;
  }*/

  veriOku() async {
    var gelenJson =
        await DefaultAssetBundle.of(context).loadString("assets/Category.json");
    //debugPrint(gelenJson);

    LinkedHashMap<String, dynamic> map = json.decode(gelenJson.toString());
    Category category = Category.fromJson(map);
    for (var i in category.categoryList) debugPrint("KeyList: " + i);
    SubCategory subCategory = category.getSubCategory("Ders");
    for (var i in category.categoryList) {
      debugPrint("Ders KeyList: " + i);
    }
    Data data = subCategory.getData("Diğer");
    for (var i in data.datas) {
      debugPrint("Diğer List: " + i);
    }
  }
}
