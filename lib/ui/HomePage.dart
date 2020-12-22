import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_star_rating/flutter_star_rating.dart';
import 'package:hizmet_mobil_uygulama/models/Category.dart';
import 'package:hizmet_mobil_uygulama/models/Hizmet.dart';
import 'package:hizmet_mobil_uygulama/models/User_.dart';
import 'package:hizmet_mobil_uygulama/ui/HizmetVerPageNew.dart';
import 'package:hizmet_mobil_uygulama/viewmodel/hizmet_model.dart';
import 'package:hizmet_mobil_uygulama/viewmodel/user_model.dart';
import 'package:provider/provider.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'ProfilePage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentNavigationBarIndex;
  Category _category;
  String _searchedWord;
  List<Hizmet> _hizmetler;
  bool _subCategoryView;
  List<dynamic> _subcategoryList;
  String selectCategory;
  String selectSubCategory;
  String selectHizmet;
  var _hizmetModel;
  bool _hizmetView;

  List<String> _hizmetList;

  @override
  void initState() {
    super.initState();
    _currentNavigationBarIndex = 0;
    _subCategoryView = false;
    _hizmetler = [];

    //readFilterHizmet("Ders", "Spor Dersleri");
    /*Hizmet hizmett = Hizmet.Info(
        "sadsadasdasd",
        "asdadasd",
        "Kurumsal",
        "Mobil Uygulama",
        "aJ6PFs34srNEX3GLjqlaDFo18T53",
        "yazılım",
        "burdur",
        500);*/
  }

  readFilterHizmet(String category, String subCategory, String hizmet) async {
    final _hizmetModel = Provider.of<HizmetModel>(context, listen: false);
    try {
      await _hizmetModel.readFilterHizmet(
          category: category, subCategory: subCategory, hizmet: hizmet);
      if (_hizmetModel.hizmetler != null) {
        _hizmetler = _hizmetModel.hizmetler;
      }
    } catch (e) {
      debugPrint("Debugg");
    }
    setState(() {
      _hizmetler;
    });
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
    _hizmetView = true;
    _hizmetList =
        _category.getSubCategory(selectCategory).getData(selectSubCategory);
  }

  hizmetCard(Hizmet hizmet) async {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    User_ userCard = await _userModel.differentUser(hizmet.publisher);
    return Card(
      child: ListTile(
        title: Text(hizmet.title),
        subtitle: Text(hizmet.detail),
        leading: Column(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(userCard.profileURL),
            ),
            Text(userCard.name + " " + userCard.surname),
          ],
        ),
      ),
    );
  }

  Widget categoryList(List<String> categoryList, double size,
      {Function setState}) {
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
                        onTap: () {
                          if (selectCategory == null) {
                            setState(() {
                              selectCategory = categoryList[index];
                              subCategoryListInit(selectCategory);
                              _subCategoryView;
                            });
                          } else if (selectSubCategory == null) {
                            setState(() {
                              selectSubCategory = categoryList[index];
                              hizmetlerInit(selectCategory, selectSubCategory);
                              _subCategoryView;
                            });
                          } else if (selectHizmet == null) {
                            setState(() {
                              selectHizmet = categoryList[index];
                              _subCategoryView;
                            });
                          }
                        },
                        child: Container(
                          height: size,
                          width: size,
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                    "https://media-exp1.licdn.com/dms/image/C4E03AQHzHgb0LxczlQ/profile-displayphoto-shrink_800_800/0/1581495839216?e=1614211200&v=beta&t=AepGW-2sHNwfjNl66CA2-ZD2oaVCpijNy0UODvru3A8")),
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

  @override
  Widget build(BuildContext context) {
    UserModel _userModel = Provider.of<UserModel>(context);
    final _hizmetModel = Provider.of<HizmetModel>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        exit(0);
      },
      child: Scaffold(
        bottomNavigationBar: ConvexAppBar(
            onTap: (position) {
              setState(() {
                _currentNavigationBarIndex = position;
              });
              if (_currentNavigationBarIndex == 2) {
                return Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HizmetVerPageNew()));
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
            ]),
        body: FutureBuilder(
          future: connectJson(),
          builder: (context, snapshot) {
            Widget newsListSliver;
            if (snapshot.hasData) {
              newsListSliver = CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    automaticallyImplyLeading: false,
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
                                    backgroundImage: NetworkImage(
                                        _userModel.user.profileURL)),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProfilePage()));
                                },
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.phone),
                              onPressed: () {
                                _hizmetModel.readFilterHizmet(
                                    category: selectCategory,
                                    subCategory: selectSubCategory,
                                    hizmet: selectHizmet);
                              },
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
                    floating: true,
                  ),
                  SliverToBoxAdapter(
                      child: Container(
                    alignment: Alignment.topCenter,
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        GestureDetector(
                          child: HideContainer(selectCategory, 50),
                          onTap: () {
                            setState(() {
                              if (selectCategory != null &&
                                  selectSubCategory == null) {
                                selectCategory = null;
                              }
                            });
                          },
                        ),
                        GestureDetector(
                          child: HideContainer(selectSubCategory, 40),
                          onTap: () {
                            setState(() {
                              if (selectSubCategory != null &&
                                  selectHizmet == null) {
                                selectSubCategory = null;
                              }
                            });
                          },
                        ),
                        GestureDetector(
                          child: HideContainer(selectHizmet, 30),
                          onTap: () {
                            setState(() {
                              if (selectHizmet != null) {
                                selectHizmet = null;
                              }
                            });
                          },
                        ),
                        Expanded(
                          child: Selected() != null ? Selected() : Container(),
                        )
                      ],
                    ),
                  )),
                  //newsListSliver,
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        debugPrint("SliverChildBuilderDelegate 322.Satır");
                        return Consumer<HizmetModel>(
                          builder: (context, hizmetModel, child) {

                            return Expanded(
                              child:  Card(
                                child: ListTile(
                                  title: Text(hizmetModel
                                      .hizmetler[0].title),
                                  subtitle: Text(hizmetModel
                                      .hizmetler[0].detail),
                                ),
                              ),
                              /*ListView.builder(
                                itemBuilder: (context, index2) {
                                  if (hizmetModel.hizmetler.isEmpty)
                                    return Container();
                                  else
                                    return Card(
                                      child: ListTile(
                                        title: Text(hizmetModel
                                            .hizmetler[index2].title),
                                        subtitle: Text(hizmetModel
                                            .hizmetler[index2].detail),
                                      ),
                                    );
                                },
                                itemCount: hizmetModel.hizmetler.length,
                              ),*/
                            );
                          },
                        );
                        /*FutureBuilder(
                          future: _hizmetModel.readFilterHizmet(
                              category: selectCategory,
                              subCategory: selectSubCategory,
                              hizmet: selectHizmet),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              debugPrint("if");
                              Hizmet hizmet2 = snapshot.data[index];
                              return Card(
                                child: ListTile(
                                  title: Text(hizmet2.title),
                                  subtitle: Text(hizmet2.detail),
                                ),
                              );
                            } else {
                              debugPrint("else");
                              return Center(
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                        );*/
                        //else return CircularProgressIndicator(backgroundColor: Colors.red,);
                      },childCount: 2,
                    ),
                  ),
                ],
              );
            } else {
              newsListSliver = Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.red,
                ),
              );
            }
            return newsListSliver;
          },
        ),
      ),
    );
  }

/*Dialog(child: CarouselSlider(photoPaths:["assets/carouselPhotos/photo1.jpg","assets/carouselPhotos/photo2.jpg","assets/carouselPhotos/photo3.jpg"]),),*/
  HideContainer(String name, double size) {
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
                fit: BoxFit.fill,
                image: NetworkImage(
                    "https://media-exp1.licdn.com/dms/image/C5603AQGYY7KwmBuSTA/profile-displayphoto-shrink_200_200/0/1558715457827?e=1613606400&v=beta&t=PPKBiSjJbAGRF0yfMlb1DlotvAPm_c2XdVzZ4VT0Wvg"),
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

  Selected() {
    if (selectCategory == null) {
      return categoryList(_category.categoryList, 50, setState: setState);
    } else if (selectSubCategory == null) {
      return categoryList(_subcategoryList, 50, setState: setState);
    } else if (selectHizmet == null) {
      return categoryList(_hizmetList, 50, setState: setState);
    } else {
      //readFilterHizmet(selectCategory, selectSubCategory, selectHizmet);
    }
  }
}
