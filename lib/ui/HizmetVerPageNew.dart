import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hizmet_mobil_uygulama/models/Category.dart';
import 'package:hizmet_mobil_uygulama/models/CategoryIcon.dart';
import 'package:hizmet_mobil_uygulama/utils/ToastMessage.dart';
import 'package:hizmet_mobil_uygulama/viewmodel/hizmet_model.dart';
import 'package:hizmet_mobil_uygulama/viewmodel/user_model.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HizmetVerPageNew extends StatefulWidget {
  @override
  _HizmetVerPageNewState createState() => _HizmetVerPageNewState();
}

class _HizmetVerPageNewState extends State<HizmetVerPageNew> {
  Category _category;
  bool _subCategoryView;
  bool _hizmetView;
  List<String> _subcategoryList;
  List<String> _hizmetList;
  List<GlobalKey<FormFieldState>> _formkey = [];
  TextEditingController _aciklama = TextEditingController();
  TextEditingController _title = TextEditingController();
  TextEditingController _fiyat = TextEditingController();
  int _activeStep;
  String categoryName;
  int categoryNameIndex;
  String subCategoryName;
  String selectCategory;
  String selectSubCategory;
  String selectHizmet;
  int selectCategoryIndex;
  int selectSubCategoryIndex;
  int selectHizmetIndex;
  CategoryIcon categoryIcon;

  @override
  void initState() {
    super.initState();
    _activeStep = 0;
    _subCategoryView = false;
    _hizmetView = false;
    _formkey.add(new GlobalKey<FormFieldState>());
    _formkey.add(new GlobalKey<FormFieldState>());
    _formkey.add(new GlobalKey<FormFieldState>());
    _formkey.add(new GlobalKey<FormFieldState>());
    categoryIcon = CategoryIcon(_category);
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Scaffold(
      /*floatingActionButton: FloatingActionButton(
        child: Icon(Icons.close),
        onPressed: () {
          Navigator.pop(context);
        },
      ),*/
      body: FutureBuilder(
        future: connectJson(),
        builder: (context, snapshot) {
          Widget newsListSliver;
          if (snapshot.hasData) {
            newsListSliver = _hizmetVerStepper(setState);
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

      //_hizmetVerStepper(setState)
    );
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

  categoryList(List<String> stringList, int durum,
      //durum = 1 kategori , durum = 2 sub categori , durum = 3 hizmet
      {Function onPressedFunction,
      Function setState}) {
    return Container(
      padding: EdgeInsets.all(5),
      height: 150.0,
      child: stringList.length != 0
          ? ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: stringList.length,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          categoryName = stringList[index];
                          categoryNameIndex = index;
                          debugPrint(
                              "categorylistesinin boyutu ${stringList.length}");
                        });
                        if (onPressedFunction != null) {
                          setState(() {
                            _subCategoryView;
                            _subcategoryList.length;
                            _hizmetView;
                            _hizmetList.length;
                          });
                        }
                      },
                      child: Container(
                        height: 75,
                        width: 75,
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: categoryName == stringList[index]
                                  ? Colors.green
                                  : Colors.deepOrange,
                              width: 5),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(
                              categoryIcon.GetIconHizmetVer(
                                              index,
                                              durum,
                                              selectCategoryIndex!=null?selectCategoryIndex:null,
                                              selectSubCategoryIndex!=null?selectSubCategoryIndex:null,
                                              selectHizmetIndex!=null?selectHizmetIndex:null) !=
                                          null
                                  ? categoryIcon.GetIconHizmetVer(
                                      index, durum, selectCategoryIndex!=null?selectCategoryIndex:null,
                                  selectSubCategoryIndex!=null?selectSubCategoryIndex:null,
                                  selectHizmetIndex!=null?selectHizmetIndex:null)
                                  : "assets/Category/Cat111.png",
                            ),
                          ),
                          //color: Colors.blue,
                          borderRadius: new BorderRadius.all(
                              new Radius.circular(
                                  20.0)), //kenarları yuvarlaklaştırır
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        stringList[index],
                        style: TextStyle(
                          fontSize: 10,
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

  connectJson() async {
    var gelenJson =
        await DefaultAssetBundle.of(context).loadString("assets/Category.json");
    LinkedHashMap<String, dynamic> map = json.decode(gelenJson.toString());
    _category = Category.fromJson(map);
    return _category.categoryList;
  }

  _hizmetVerStepper(Function setState) {
    return ListView(
      children: <Widget>[
        SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        "Hizmet Ver",
                        style: GoogleFonts.varelaRound(
                            fontSize: 30, color: Colors.black),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        size: 35,
                      ),
                      alignment: Alignment.topRight,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                Divider(
                  color: Colors.blueAccent,
                ),
                HideContainer(selectCategory, 75, 1),
                HideContainer(selectSubCategory, 50, 2),
                HideContainer(selectHizmet, 40, 3),
              ],
            ),
          ),
        ),
        SingleChildScrollView(
          child: Container(
            child: Stepper(
              physics: ClampingScrollPhysics(),
              onStepTapped: (index) {
                if (index < _activeStep ||
                    ((selectCategory != null) &&
                        (index > 1 && selectSubCategory != null) &&
                        (index > 2 && selectHizmet != null)))
                  _activeStep = index;

                setState(() {
                  _activeStep;
                  if (_activeStep == 0) {
                    selectCategory = null;
                    selectSubCategory = null;
                    selectHizmet = null;
                    selectCategoryIndex = null;
                    selectSubCategoryIndex = null;
                    selectHizmetIndex = null;
                  }
                  if (_activeStep == 1) {
                    selectHizmet = null;
                    selectHizmetIndex = null;
                  }
                });
              },
              controlsBuilder: (BuildContext context,
                  {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CupertinoButton(
                      child: Text("Geri Dön"),
                      onPressed: _activeStep != 0 ? onStepCancel : () {},
                    ),
                    CupertinoButton(
                      child: Text(
                          _activeStep < _stepListInit(setState).length - 1
                              ? "İlerle"
                              : "Bitir"),
                      onPressed: onStepContinue,
                    ),
                  ],
                );
              },
              currentStep: _activeStep,
              onStepContinue: () {
                setState(() {
                  continueButton(_activeStep);
                });
              },
              onStepCancel: () {
                setState(() {
                  if (_activeStep == 1) {
                    selectCategory = null;
                    selectCategoryIndex = null;
                  }
                  if (_activeStep == 2) {
                    selectSubCategory = null;
                    selectSubCategoryIndex = null;
                  }
                  if (_activeStep == 3) {
                    selectHizmet = null;
                    selectHizmetIndex = null;
                  }
                  if (_activeStep != 0) _activeStep--;
                });
              },
              steps: _stepListInit(setState),
            ),
          ),
        ),
      ],
    );
  }

  List<Step> _stepListInit(Function setState) {
    List<Step> steps = [
      Step(
          title: Text("Kategoriler"),
          content: FormField(
              key: _formkey[0],
              validator: (value) {
                if (categoryName != null) {
                  selectCategory = categoryName;
                  subCategoryListInit(selectCategory);
                  selectCategoryIndex = categoryNameIndex;
                  categoryName = null;
                  categoryNameIndex = null;
                  return null;
                } else {
                  return "Kategori secmeniz gerekmektedir";
                }
              },
              builder: (state) {
                return categoryList(_category.categoryList, 1,
                    onPressedFunction: selectCategory != null
                        ? subCategoryListInit(selectCategory)
                        : null,
                    setState: setState);
              })),
      Step(
        title: Text("Alt Kategoriler"),
        content: FormField(
            key: _formkey[1],
            validator: (value) {
              if (categoryName != null) {
                selectSubCategory = categoryName;
                selectSubCategoryIndex = categoryNameIndex;
                debugPrint(
                    "Seçilen Kategori $selectCategory Seçilen alt kategori $selectSubCategory indexi:$selectSubCategoryIndex");
                categoryName = null;
                categoryNameIndex = null;
                return null;
              } else {
                return "Kategori secmeniz gerekmektedir";
              }
            },
            builder: (state) {
              return _subcategoryList != null
                  ? categoryList(_subcategoryList, 2,
                      onPressedFunction: selectSubCategory != null
                          ? hizmetlerInit(selectCategory, selectSubCategory)
                          : null,
                      setState: setState)
                  : Container();
            }),
      ),
      Step(
        title: Text("Verilecek Hizmet"),
        content: FormField(
            key: _formkey[2],
            validator: (value) {
              if (categoryName != null) {
                selectHizmet = categoryName;
                selectHizmetIndex = categoryNameIndex;
                categoryName = null;
                categoryNameIndex = null;
                return null;
              } else {
                return "Kategori secmeniz gerekmektedir";
              }
            },
            builder: (state) {
              return _hizmetList != null
                  ? categoryList(_hizmetList, 3, setState: setState)
                  : Container();
            }),
      ),
      Step(
        isActive: _activeStep == 3 ? true : false,
        title: Text(
          _activeStep == 3 ? "İlan Bilgileri" : "Kisi...",
        ),
        content: Column(
          children: [
            FormField(
                key: _formkey[3],
                builder: (state) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                          controller: _title,
                          decoration: InputDecoration(
                              labelText: "İlan Başlığı",
                              border: OutlineInputBorder()),
                          //validator: _nameValidator,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value != null) {
                              debugPrint("bos degil");
                              return null;
                            } else {
                              debugPrint("hata var");
                              return "hata";
                            }
                          }),
                      SizedBox(height: 5),
                      TextFormField(
                        controller: _aciklama,
                        decoration: InputDecoration(
                            labelText: "Açıklama",
                            border: OutlineInputBorder()),
                        //validator: _nameValidator,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      SizedBox(height: 5),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _fiyat,
                        decoration: InputDecoration(
                            labelText: "Fiyat", border: OutlineInputBorder()),
                        //validator: _nameValidator,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ],
                  );
                })
          ],
        ),
      ),
    ];
    return steps;
  }

  void continueButton(int activeStep) {
    if (_formkey[activeStep].currentState.validate()) {
      if (activeStep < _stepListInit(setState).length - 1) {
        _formkey[activeStep].currentState.save();
        activeStep++;
        setState(() {
          _activeStep = activeStep;
        });
      } else {
        _formkey[activeStep].currentState.save();
        final _hizmetModel = Provider.of<HizmetModel>(context, listen: false);
        final _userModel = Provider.of<UserModel>(context, listen: false);

        _hizmetModel.createHizmet(
            title: _title.text,
            category: selectCategory,
            subCategory: selectSubCategory,
            hizmet: selectHizmet,
            publisher: _userModel.user.userID,
            detail: _aciklama.text,
            address: "Zeytniburnu",
            payment: double.parse(_fiyat.text));
        Navigator.pop(context);
        debugPrint("categoryName: " + selectCategory);
        debugPrint("subCategoryName: " + selectSubCategory);
      }
    } else
      showToast(context, "Lütfen Bir Kategori Seçiniz.", Colors.red);
  }

  HideContainer(String name, double size, int durum) {
    return Visibility(
      visible: name != null ? true : false,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 15),
            child: Row(children: [
              Container(
                height: size,
                width: size,
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12, width: 5),
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage(SelectDurum(durum) != null
                        ? SelectDurum(durum)
                        : "assets/Category/Cat111.png"),
                  ),
                  color: Colors.blue,
                  borderRadius: new BorderRadius.all(
                      new Radius.circular(20.0)), //kenarları yuvarlaklaştırır
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
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
          Divider(
            color: Colors.blueAccent,
          ),
        ],
      ),
    );
  }

  String SelectDurum(int durum) {
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
}
