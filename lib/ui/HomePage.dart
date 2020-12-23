import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hizmet_mobil_uygulama/models/Category.dart';
import 'package:hizmet_mobil_uygulama/models/CategoryIcon.dart';
import 'package:hizmet_mobil_uygulama/models/Hizmet.dart';
import 'package:hizmet_mobil_uygulama/ui/HizmetVerPageNew.dart';
import 'package:hizmet_mobil_uygulama/viewmodel/hizmet_model.dart';
import 'package:provider/provider.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'ProfilePage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentNavigationBarIndex;
  Category _category;
  String _searchedWord;
  int selectCategoryIndex;
  int selectSubCategoryIndex;
  int selectHizmetIndex;
  bool _subCategoryView;
  List<dynamic> _subcategoryList;
  String selectCategory;
  CategoryIcon categoryIcon;
  String selectSubCategory;
  String selectHizmet;
  List<String> _hizmetList;
  List<Hizmet> _tempHizmetler;

  @override
  void initState() {
    super.initState();
    _currentNavigationBarIndex = 0;
    _subCategoryView = false;
    categoryIcon = CategoryIcon(_category);
  }

  @override
  Widget build(BuildContext context) {
    HizmetModel _hizmetModel = Provider.of<HizmetModel>(context);
    return WillPopScope(
      onWillPop: () async {
        exit(0);
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: GestureDetector(
                      child: CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/carouselPhotos/photo1.jpg")),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilePage()));
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5),
                    width: MediaQuery.of(context).size.width / 2,
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        prefixIcon: IconButton(
                          icon: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                        ),
                        hintText: "Hizmet Ara",
                      ),
                      onChanged: (searchedWord) {
                        setState(() {
                          _searchedWord = searchedWord;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            FutureBuilder(
              future: connectJson(),
              builder: (context, snapshot) {
                Widget filterContainer;
                if (snapshot.hasData) {
                  filterContainer = Container(
                    child: Container(
                      alignment: Alignment.topCenter,
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          GestureDetector(
                            child: HideContainer(selectCategory, 50, 1),
                            onTap: () {
                              setState(() {
                                if (selectCategory != null &&
                                    selectSubCategory == null) {
                                  selectCategory = null;
                                  selectCategoryIndex = null;
                                  _hizmetModel.hizmetler = null;
                                }
                              });
                            },
                          ),
                          GestureDetector(
                            child: HideContainer(selectSubCategory, 40, 2),
                            onTap: () {
                              setState(() {
                                if (selectSubCategory != null &&
                                    selectHizmet == null) {
                                  selectSubCategory = null;
                                  selectSubCategoryIndex = null;
                                  _hizmetModel.hizmetler = _tempHizmetler;
                                }
                              });
                            },
                          ),
                          GestureDetector(
                            child: HideContainer(selectHizmet, 30, 3),
                            onTap: () {
                              setState(() {
                                if (selectHizmet != null) {
                                  selectHizmet = null;
                                  selectHizmetIndex = null;
                                  _hizmetModel.hizmetler = _tempHizmetler;
                                }
                              });
                            },
                          ),
                          Expanded(
                            child:
                                Selected() != null ? Selected() : Container(),
                          )
                        ],
                      ),
                    ),
                  );
                } else
                  filterContainer = CircularProgressIndicator(
                    backgroundColor: Colors.red,
                  );
                return filterContainer;
              },
            ),
            Consumer<HizmetModel>(
              builder: (context, hizmetModel, child) {
                if (hizmetModel.hizmetler != null) {
                  return Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(hizmetModel.hizmetler[index].title),
                            subtitle: Text(hizmetModel.hizmetler[index].detail),
                          ),
                        );
                      },
                      itemCount: hizmetModel.hizmetler.length,
                    ),
                  );
                } else {
                  return Center(
                    child: Text("Hizmet Bulunamadı"),
                  );
                }
              },
            ),
          ],
        ),
        bottomNavigationBar: ConvexAppBar(
          onTap: (position) {
            setState(() {
              _currentNavigationBarIndex = position;
            });
            if (_currentNavigationBarIndex == 2) {
              return Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HizmetVerPageNew()));
            }
          },
          backgroundColor: Colors.white,
          color: Color.fromRGBO(34, 63, 71, 1),
          activeColor: Colors.green,
          style: TabStyle.fixedCircle,
          items: [
            TabItem(title: "Anasayfa", icon: Icons.home_outlined),
            TabItem(title: "Hizmetlerim", icon: Icons.check_box_outlined),
            TabItem(title: "Hizmet Ver", icon: Icons.add_box_outlined),
            TabItem(title: "Bildirimler", icon: Icons.notifications_outlined),
            TabItem(title: "Sohbet", icon: Icons.chat_outlined)
          ],
        ),
      ),
    );
  }

  connectJson() async {
    String fromJson =
        await DefaultAssetBundle.of(context).loadString("assets/Category.json");
    LinkedHashMap<String, dynamic> map = json.decode(fromJson.toString());
    _category = Category.fromJson(map);
    return _category.categoryList;
  }

  subCategoryListInit(String category) {
    _subCategoryView = true;
    _subcategoryList = _category.getSubCategory(category).subCategoryList;
  }

  hizmetlerInit(String category, String subCategory) {
    _hizmetList = _category.getSubCategory(category).getData(subCategory);
    debugPrint(_hizmetList.toString());
    return _hizmetList;
  }

  getAllHizmet(String category) {
    List<List<String>> allHizmet = [];
    var yeniHizmetList = _category.getSubCategory(category).subCategoryList;
    for (int i = 0; i < yeniHizmetList.length; ++i) {
      var newHizmet =
          _category.getSubCategory(category).getData(yeniHizmetList[i]);
      allHizmet.add(newHizmet);
    }
    return allHizmet;
  }

  Widget categoryList(List<String> categoryList, double size,
      {Function setState}) {
    final _hizmetModel = Provider.of<HizmetModel>(context, listen: false);
    return Container(
      padding: EdgeInsets.all(5),
      child: categoryList.length != 0
          ? ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoryList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    GestureDetector(
                        onTap: () async {
                          if (selectCategory == null) {
                            selectCategory = categoryList[index];
                            selectCategoryIndex = index;
                            subCategoryListInit(selectCategory);
                            _subCategoryView;
                           await _hizmetModel.readFilterHizmet(
                                category: selectCategory,
                                subCategory: null,
                                hizmet: null,
                                categories: _subcategoryList,
                                subCategories: getAllHizmet(selectCategory));
                          } else if (selectSubCategory == null) {
                            selectSubCategory = categoryList[index];
                            selectSubCategoryIndex = index;
                            hizmetlerInit(selectCategory, selectSubCategory);
                            _tempHizmetler=_hizmetModel.hizmetler;
                             await _hizmetModel.readFilterHizmet(
                                category: selectCategory,
                                subCategory: selectSubCategory,
                                hizmet: null,
                                categories: _hizmetList);
                          } else if (selectHizmet == null) {
                            selectHizmet = categoryList[index];
                            selectHizmetIndex = index;
                            _subCategoryView;
                            _tempHizmetler=_hizmetModel.hizmetler;
                             await _hizmetModel.readFilterHizmet(
                                category: selectCategory,
                                subCategory: selectSubCategory,
                                hizmet: selectHizmet);
                          }
                        },
                        child: Container(
                          height: size,
                          width: size,
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.contain,
                              image: AssetImage(categoryIcon.GetIcon(
                                          index,
                                          selectCategoryIndex,
                                          selectSubCategoryIndex,
                                          selectHizmetIndex) !=
                                      null
                                  ? categoryIcon.GetIcon(
                                      index,
                                      selectCategoryIndex,
                                      selectSubCategoryIndex,
                                      selectHizmetIndex)
                                  : "assets/Category/Cat111.png"),
                            ),
                            color: Colors.blue,
                            borderRadius: new BorderRadius.all(
                                new Radius.circular(
                                    20.0)), //kenarları yuvarlaklaştırır
                          ),
                        )),
                    Container(
                      child: Text(
                        categoryList[index],
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.red,
              ),
            ),
    );
  }

  HideContainer(String name, double size, int durum) {
    return Visibility(
      visible: name != null ? true : false,
      child: Container(
        padding: EdgeInsets.only(top: 9, left: 3, right: 3),
        child: Column(children: [
          Container(
            height: size,
            width: size,
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red, width: 3),
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage(Durum(durum) != null
                    ? Durum(durum)
                    : "assets/Category/Cat111.png"),
              ),
              color: Colors.blue,
              borderRadius: new BorderRadius.all(
                  new Radius.circular(20.0)), //kenarları yuvarlaklaştırır
            ),
          ),
          Container(
            child: Text(
              name != null ? name : "Kategori",
              style: TextStyle(
                fontSize: size / 3,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ]),
      ),
    );
  }

  String Durum(int durum) {
    if (durum == 1) {
      return categoryIcon.SelectGetIcon(selectCategoryIndex, null, null);
    }
    if (durum == 2) {
      return categoryIcon.SelectGetIcon(
          selectCategoryIndex, selectSubCategoryIndex, null);
    }
    if (durum == 3) {
      return categoryIcon.SelectGetIcon(
          selectCategoryIndex, selectSubCategoryIndex, selectHizmetIndex);
    }
  }

  Selected() {
    if (selectCategory == null) {
      return categoryList(_category.categoryList, 50, setState: setState);
    } else if (selectSubCategory == null) {
      return categoryList(_subcategoryList, 50, setState: setState);
    } else if (selectHizmet == null) {
      return categoryList(_hizmetList, 50, setState: setState);
    } else {}
  }
}
