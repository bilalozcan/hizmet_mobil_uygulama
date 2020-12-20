import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hizmet_mobil_uygulama/models/Category.dart';
import 'package:hizmet_mobil_uygulama/utils/ToastMessage.dart';

class HizmetVerPageNew extends StatefulWidget {
  @override
  _HizmetVerPageNewState createState() => _HizmetVerPageNewState();
}

class _HizmetVerPageNewState extends State<HizmetVerPageNew> {
  Category _category;
  bool _subCategoryView;
  List<dynamic> _subcategoryList;
  List<GlobalKey<FormFieldState>> _formkey = [];
  TextEditingController _aciklama = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _fiyat = TextEditingController();
  int _activeStep;
  String categoryName;
  String subCategoryName;
  String selectCategory;
  String selectSubCategory;

  @override
  void initState() {
    super.initState();
    _activeStep = 0;
    _subCategoryView = false;
    _formkey.add(new GlobalKey<FormFieldState>());
    _formkey.add(new GlobalKey<FormFieldState>());
    _formkey.add(new GlobalKey<FormFieldState>());
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.close),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
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

  onPressedFunc(String category) {
    debugPrint("onpressedFunc çalıştı satır 304");
    _subCategoryView = true;
    _subcategoryList = _category.getSubCategory(category).subCategoryList;
  }

  categoryList(List<String> categoryList,
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          categoryName = categoryList[index];
                        });
                        if (onPressedFunction != null) {
                          onPressedFunction(categoryList[index]);
                          setState(() {
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
                          border:Border.all(
                              color:categoryName == categoryList[index] ? Colors.green : Colors.deepOrange,
                              width: 5
                          ),
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
                      ),
                    ),
                    Container(
                      child: Text(
                        categoryList[index],
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
        Container(
          padding: EdgeInsets.only(top:25),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Kategori",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight:FontWeight.bold
              ),),
              Divider(
                color: Colors.blueAccent,
              ),

              HideContainer(selectCategory,75),
              Divider(
                color: Colors.blueAccent,
              ),
              HideContainer(selectSubCategory,50),
              Divider(
                color: Colors.blueAccent,
              ),
              ],
          ),
        ),
        Container(
          child: Stepper(
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
                    child: Text(_activeStep < _stepListInit(setState).length - 1
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
                if (_activeStep != 0) _activeStep--;
              });
            },
            steps: _stepListInit(setState),
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
                  selectCategory=categoryName;
                  categoryName = null;
                  return null;
                } else {
                  return "Kategori secmeniz gerekmektedir";
                }
              },
              builder: (state) {
                return categoryList(_category.categoryList,
                    onPressedFunction: onPressedFunc, setState: setState);
              })),
      Step(
        title: Text("Alt Kategoriler"),
        content: FormField(
            key: _formkey[1],
            validator: (value) {
              if (categoryName != null) {
                selectSubCategory=categoryName;
                categoryName = null;
                return null;
              } else {
                return "Kategori secmeniz gerekmektedir";
              }
            },
            builder: (state) {
              return _subcategoryList != null
                  ? categoryList(_subcategoryList, setState: setState)
                  : Container();
            }),
      ),
      Step(
        isActive: _activeStep == 2 ? true : false,
        title: Text(
          _activeStep == 2 ? "İlan Bilgileri" : "Kisi...",
        ),
        content: Column(
          children: [
            FormField(
                key: _formkey[2],
                builder: (state) {
                  return Column(
                    children: [
                      SizedBox(height: 5,),
                      TextFormField(
                          controller: _address,
                          decoration: InputDecoration(
                              labelText: "İlan Başlığı", border: OutlineInputBorder()),
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
                        keyboardType:TextInputType.number ,
                        controller:_fiyat ,
                        decoration: InputDecoration(
                            labelText: "Fiyat",
                            border: OutlineInputBorder()),
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
      }
    } else
      showToast(context, "Lütfen Bir Kategori Seçiniz.", Colors.red);
  }
  HideContainer(String name,double size){
    return Visibility(

      visible: name != null ? true : false,
      child: Container(
        padding: EdgeInsets.only(left: 15),
        child: Row(
          children: [

            Container(
              height: size,
              width: size,
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                border:Border.all(
                    color: Colors.black12,
                    width: 5
                ),
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
            ),
            Container(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                name!= null ? name : "Kategori",
                style: TextStyle(
                  fontSize: size/3,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
