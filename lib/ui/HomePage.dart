import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hizmet_mobil_uygulama/models/Category.dart';
import 'package:hizmet_mobil_uygulama/models/CategoryIcon.dart';
import 'package:hizmet_mobil_uygulama/models/Hizmet.dart';
import 'package:hizmet_mobil_uygulama/ui/HizmetDetailPage.dart';
import 'package:hizmet_mobil_uygulama/ui/HizmetVerPageNew.dart';
import 'package:hizmet_mobil_uygulama/viewmodel/hizmet_model.dart';
import 'package:hizmet_mobil_uygulama/viewmodel/user_model.dart';
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
  List<Hizmet> _temps0;
  List<Hizmet> _temps1;

  @override
  void initState() {
    super.initState();
    _currentNavigationBarIndex = 0;
    _subCategoryView = false;
    categoryIcon = CategoryIcon(_category);
    //_temps=List<List<Hizmet>>();
  }

  @override
  Widget build(BuildContext context) {
    HizmetModel _hizmetModel = Provider.of<HizmetModel>(context);
    UserModel _userModel = Provider.of<UserModel>(context);
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
                              NetworkImage(_userModel.user.profileURL)),
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
                    width: MediaQuery.of(context).size.width / 1.2,
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
        body: widgetCatalog(_hizmetModel),
        bottomNavigationBar: ConvexAppBar(
          onTap: (position) {
            setState(() {
              _currentNavigationBarIndex = position;
            });
            if (_currentNavigationBarIndex == 2) {
              setState(() {
              _currentNavigationBarIndex = 0;
              });
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

  Widget widgetCatalog(hizmetModel) {
    debugPrint(
        "_currentNavigationBarIndex:" + _currentNavigationBarIndex.toString());
    if (_currentNavigationBarIndex == 0)
      return Column(
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
                                hizmetModel.hizmetler = null;
                              }
                            });
                          },
                        ),
                        GestureDetector(
                          child: HideContainer(selectSubCategory, 45, 2),
                          onTap: () {
                            setState(() {
                              if (selectSubCategory != null &&
                                  selectHizmet == null) {
                                selectSubCategory = null;
                                selectSubCategoryIndex = null;
                                hizmetModel.hizmetler = _temps0;
                              }
                            });
                          },
                        ),
                        GestureDetector(
                          child: HideContainer(selectHizmet, 40, 3),
                          onTap: () {
                            setState(() {
                              if (selectHizmet != null) {
                                selectHizmet = null;
                                selectHizmetIndex = null;
                                hizmetModel.hizmetler = _temps1;
                              }
                            });
                          },
                        ),
                        Expanded(
                          child: Selected() != null ? Selected() : Container(),
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
                    child: CustomScrollView(
                  semanticChildCount: 6,
                  slivers: <Widget>[
                    SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return GestureDetector(
                            child: HizmetContainer(index, hizmetModel),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>HizmetDetailPage(hizmetModel.hizmetler[index])));
                            },
                          );
                        },
                        childCount: hizmetModel.hizmetler.length,
                      ),
                    ),
                  ],
                )
                    /*ListView.builder(
                    itemBuilder: (context, index) {
                      return HizmetContainer();
                      Card(
                        child: ListTile(
                          title: Text(hizmetModel.hizmetler[index].title),
                          subtitle: Text(hizmetModel.hizmetler[index].detail),
                          leading: Icon(Icons.android),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>HizmetDetailPage(hizmetModel.hizmetler[index])));
                          },
                        ),
                      );
                    },
                    itemCount: hizmetModel.hizmetler.length,
                  ),*/
                    );
              } else {
                return Center(
                  child: Text("Hizmet Bulunamadı"),
                );
              }
            },
          ),
        ],
      );
    else if (_currentNavigationBarIndex == 1)
      return Container(
        child: Center(
          child: Text("Hizmetlerim"),
        ),
      );
    else if (_currentNavigationBarIndex == 3)
      return Container(
        child: Center(
          child: Text("Bildirimler"),
        ),
      );
    else if (_currentNavigationBarIndex == 4)
      return Container(
        child: Center(
          child: Text("Sohbet"),
        ),
      );
  }

  HizmetContainer(int index, var hizmetModel) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 150,
        alignment: Alignment.topLeft,
        decoration: BoxDecoration(
          border: Border.all(width: 3,color: Colors.black12),
          borderRadius: new BorderRadius.all(
              new Radius.circular(15.0)), //kenarları yuvarlaklaştırır
          color: Colors.primaries[Random().nextInt(Colors.primaries.length)].shade100,
          //color: Colors.white
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FittedBox(
                fit: BoxFit.contain,
                  child: Text(
                hizmetModel.hizmetler[index].title,
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              )),
            ),

            //SizedBox(height: 105,),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:5.0),
                    child: Text("${hizmetModel.hizmetler[index].payment} TL"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right:5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.remove_red_eye_outlined),
                        Padding(
                          padding: const EdgeInsets.only(left:5.0),
                          child: Text("${hizmetModel.hizmetler[index].review}"),
                        )
                      ],
                    ),
                  ),
                ],
              ),

            ),
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
                            //_tempHizmetler=_hizmetModel.hizmetler;
                            //debugPrint("tempHizmetler"+_tempHizmetler.toString());
                            _temps0 = _hizmetModel.hizmetler;
                            await _hizmetModel.readFilterHizmet(
                                category: selectCategory,
                                subCategory: selectSubCategory,
                                hizmet: null,
                                categories: _hizmetList);
                          } else if (selectHizmet == null) {
                            selectHizmet = categoryList[index];
                            selectHizmetIndex = index;
                            _subCategoryView;
                            //_tempHizmetler=_hizmetModel.hizmetler;
                            _temps1 = _hizmetModel.hizmetler;
                            // debugPrint("tempHizmetler"+_tempHizmetler.toString());
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
                              fit: BoxFit.scaleDown,
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
                            // border: Border.all(color: Colors.deepOrange, width: 2),
                            color: Colors.blue.shade200,
                            borderRadius: new BorderRadius.all(
                                new Radius.circular(
                                    20.0)), //kenarları yuvarlaklaştırır
                          ),
                        )),
                    Container(
                      child: Text(
                        categoryList[index],
                        style: GoogleFonts.yantramanav(
                          fontSize: 11,
                          color: Colors.black45,
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
          Center(
            child: Icon(
              Icons.close,
              size: size / 2.5,
              color: Colors.red,
            ),
          ),
          Container(
            height: size,
            width: size,
            decoration: BoxDecoration(
              //border: Border.all(color: Colors.deepOrange.shade200, width: 3,style: BorderStyle.solid),
              color: Colors.blue.shade400,
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage(Durum(durum) != null
                    ? Durum(durum)
                    : "assets/Category/Cat111.png"),
              ),
              borderRadius: new BorderRadius.all(
                  new Radius.circular(size / 3)), //kenarları yuvarlaklaştırır
            ),
          ),
          Container(
            child: Text(
              name != null ? name : "Kategori",
              style: GoogleFonts.yantramanav(
                fontSize: size / 3.5,
                color: Colors.black45,
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
