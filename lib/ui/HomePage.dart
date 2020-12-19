import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hizmet_mobil_uygulama/models/Category.dart';
import 'package:hizmet_mobil_uygulama/models/Hizmet.dart';
import 'package:hizmet_mobil_uygulama/models/User_.dart';
import 'package:hizmet_mobil_uygulama/viewmodel/hizmet_model.dart';
import 'package:hizmet_mobil_uygulama/viewmodel/user_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'ProfilePage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentNavigationBarIndex;
  Category _category;
  String _profilePhoto;
  PickedFile _profilFoto;
  String _value;
  bool _pressed;
  List<Hizmet> _hizmetler;
  bool _subCategoryView;
  List<dynamic> _subcategoryList;
  GlobalKey<FormState> _formkey;
  TextEditingController _aciklama = TextEditingController();
  TextEditingController _title = TextEditingController();
  TextEditingController _address = TextEditingController();

  @override
  void initState() {
    super.initState();
    _currentNavigationBarIndex = 0;
    _pressed = false;
    _subCategoryView = false;
    _hizmetler = List<Hizmet>();
    _formkey = GlobalKey<FormState>();
    readFilterHizmet("Kurumsal", "Mobil Uygulama");
    Hizmet hizmett = Hizmet.Info(
        "sadsadasdasd",
        "asdadasd",
        "Kurumsal",
        "Mobil Uygulama",
        "aJ6PFs34srNEX3GLjqlaDFo18T53",
        "yazılım",
        "burdur",
        500);
    _hizmetler.add(hizmett);
  }

  @override
  Widget build(BuildContext context) {
    UserModel _userModel = Provider.of<UserModel>(context);
    _profilePhoto = _userModel.user.profileURL;
    return WillPopScope(
      onWillPop: () async {
        exit(0);
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(LineAwesomeIcons.blender),
          onPressed: () {
            readFilterHizmet("Kurumsal", "Mobil Uygulama");
          },
        ),
        bottomNavigationBar: FancyBottomNavigation(
          onTabChangedListener: (position) {
            setState(() {
              _currentNavigationBarIndex = position;
            });
            if (_currentNavigationBarIndex == 1) {
              setState(() {
                _subcategoryList;
                _subCategoryView;
              });
              hizmetVerFonk();
            }
          },
          circleColor: Colors.green,
          inactiveIconColor: Colors.black,
          tabs: [
            TabData(iconData: Icons.home_outlined, title: "Anasayfa"),
            TabData(
              iconData: Icons.add_box_outlined,
              title:
                  "Hizmet Ver", /*onclick: (){
              return hizmetVerFonk();
            }*/
            ),
            TabData(iconData: Icons.check_box_outlined, title: "Hizmetler"),
            TabData(iconData: Icons.chat_outlined, title: "Sohbet")
          ],
        ),
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
                            Container(
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
                                    onPressed: () {
                                      setState(() {
                                        _pressed = true;
                                      });
                                    },
                                  ),
                                  hintText: "Hizmet Ara",
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _value = value;
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
                    child: categoryList(_category.categoryList, 25),
                  ),
                  //newsListSliver,
                  SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                    return FutureBuilder(
                      future: hizmetCard(_hizmetler[index]),
                      builder: (context, snapshot) {
                        if (snapshot.hasData)
                          return snapshot.data;
                        else
                          return CircularProgressIndicator(
                            backgroundColor: Colors.red,
                          );
                      },
                    );
                    //else return CircularProgressIndicator(backgroundColor: Colors.red,);
                  }, childCount: _hizmetler.length)),
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

  readFilterHizmet(String category, String subCategory) async {
    final HizmetModel _hizmetModel =
        Provider.of<HizmetModel>(context, listen: false);
    /*_hizmetler = await _hizmetModel.readFilterHizmet(
        category: category, subCategory: subCategory);*/
    debugPrint(_hizmetler.toString());
    setState(() {
      _hizmetler;
    });
  }

  connectJson() async {
    var gelenJson =
        await DefaultAssetBundle.of(context).loadString("assets/Category.json");
    LinkedHashMap<String, dynamic> map = json.decode(gelenJson.toString());
    _category = Category.fromJson(map);
    return _category.categoryList;
  }

  hizmetVerFonk() {
    return showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (BuildContext context, setState) {
          //Form(key: _formkey, child: Column,)
          return Form(
            key: _formkey,
            child: Container(
              child: Column(
                //dikey
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(right: 10),
                    alignment: Alignment.bottomRight,
                    /*child: ElevatedButton(
                    child: const Text('Vazgeç'),
                    onPressed: () => Navigator.pop(context),
                  )),*/
                    child: CupertinoButton(
                      child: Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  categoryList(
                      _category.categoryList, _category.categoryList.length,
                      onPressedFunction: onPressedFunc, setState: setState),
                  _subCategoryView
                      ? categoryList(_subcategoryList, _subcategoryList.length,
                          setState: setState)
                      : Container(),
                  TextFormField(
                    controller: _title,
                    decoration: InputDecoration(
                        labelText: "Hizmet Başlık",
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 5),
                  TextFormField(
                    controller: _aciklama,
                    decoration: InputDecoration(
                        labelText: "Hizmet Açıklama",
                        border: OutlineInputBorder()),
                  ),
                  TextFormField(
                    controller: _address,
                    decoration: InputDecoration(
                        labelText: "Adres",
                        border: OutlineInputBorder()),
                  ),

                ],
              ),
            ),
          );
        });
      },
    );
  }

  hizmetCard(Hizmet hizmet) async {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    User_ userCard = await _userModel.anotherUser(hizmet.publisher);
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

  onPressedFunc(String category) {
    debugPrint("onpressedFunc çalıştı satır 304");
    _subCategoryView = true;
    _subcategoryList = _category.getSubCategory(category).subCategoryList;
  }

  categoryList(List<String> categoryList, int size,
      {Function onPressedFunction, Function setState}) {
    return Container(
      padding: EdgeInsets.all(5),
      height: 150.0,
      child: categoryList.length != 0
          ? ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoryList.length,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                        onTap: () {
                          if (onPressedFunction != null) {
                            debugPrint("onTap Çalıştı Satır 324");
                            onPressedFunction(categoryList[index]);
                            setState(() {
                              debugPrint("setState çalıştı Satır 324");
                              _subCategoryView;
                              _subcategoryList.length;
                            });
                          }
                        },
                        child: Container(
                          height: 75,
                          width: 75,
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                  "https://media-exp1.licdn.com/dms/image/C5603AQGYY7KwmBuSTA/profile-displayphoto-shrink_200_200/0/1558715457827?e=1613606400&v=beta&t=PPKBiSjJbAGRF0yfMlb1DlotvAPm_c2XdVzZ4VT0Wvg"),
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
          : CircularProgressIndicator(
              backgroundColor: Colors.red,
            ),
    );
  }
/*Dialog(child: CarouselSlider(photoPaths:["assets/carouselPhotos/photo1.jpg","assets/carouselPhotos/photo2.jpg","assets/carouselPhotos/photo3.jpg"]),),*/
}
