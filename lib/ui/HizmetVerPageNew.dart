import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hizmet_mobil_uygulama/models/Category.dart';
import 'package:hizmet_mobil_uygulama/models/Hizmet.dart';
import 'package:hizmet_mobil_uygulama/utils/ToastMessage.dart';
import 'package:hizmet_mobil_uygulama/viewmodel/hizmet_model.dart';
import 'package:hizmet_mobil_uygulama/viewmodel/user_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

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
  int _activeStep;
  List<String> categoryPath=[];
  double _currentPayment;

  @override
  void initState() {
    super.initState();
    _activeStep = 0;
    _subCategoryView = false;
    _formkey.add(new GlobalKey<FormFieldState>());
    _formkey.add(new GlobalKey<FormFieldState>());
    _formkey.add(new GlobalKey<FormFieldState>());
    _currentPayment=0;
  }
  @override
  Widget build(BuildContext context) {
    setState(() {});
   return Scaffold(
       body:FutureBuilder(
         future: connectJson(),
         builder: (context, snapshot) {
           Widget newsListSliver;
           if (snapshot.hasData) {
             newsListSliver =_hizmetVerStepper(setState);
           } else {
             newsListSliver = Center(
               child: CircularProgressIndicator(
                 backgroundColor: Colors.red,
               ),
             );
           }
           return Column(children: [newsListSliver,],);
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                  onTap: () {
                    setState(() {
                      categoryPath.add(categoryList[index]);
                    });
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
  connectJson() async {
    var gelenJson =
    await DefaultAssetBundle.of(context).loadString("assets/Category.json");
    LinkedHashMap<String, dynamic> map = json.decode(gelenJson.toString());
    _category = Category.fromJson(map);
    return _category.categoryList;
  }
  _hizmetVerStepper(Function setState) {
    return Container(
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.green,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(8),
        child: Stepper(
          onStepTapped: (position){ /*İstenilirse eklenebilir... Opsiyonel*/
            setState((){_activeStep=position;});
          },
          physics: ClampingScrollPhysics(),
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
                  child: Text(_activeStep < _stepListInit(setState).length -1
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
    );
  }

  List<Step> _stepListInit(Function setState) {
    String swapSubCategory;
    List<Step> steps = [
      Step(
          title: Text("Kategoriler"),
          content: FormField(
              key: _formkey[0],
              validator: (value) {
                if (categoryPath[0] != null) {
                  return null;
                } else {
                  debugPrint("error");
                  return "Kategori secmeniz gerekmektedir";
                }
              },
              builder: (state) {
                return categoryList(
                    _category.categoryList,
                    onPressedFunction: onPressedFunc, setState: setState);
              })
      ),
      Step(
          title: Text( "Alt Kategoriler"),
          content: FormField(
              key: _formkey[1],
              validator: (value) {
                if (categoryPath[1] != null) {
                  return null;
                } else {
                  debugPrint("error");
                  return "Kategori secmeniz gerekmektedir";
                }
              },
              builder: (state) {
                return _subcategoryList!=null ? categoryList(_subcategoryList,
                    setState: setState) : Container();
              }
              ),
      ),
      Step(
        isActive: _activeStep == 2 ? true : false,
        title: Text(
          _activeStep == 2 ? "Kişisel Bilgiler" : "Kisi...",
        ),
        content: Column(
          children: [
            FormField(
                key: _formkey[2],
                builder: (state) {
                  return Column(
                    children: [
                      TextFormField(
                          controller: _address,
                          decoration: InputDecoration(
                              labelText: "Adres", border: OutlineInputBorder()),
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
                      Slider(value:_currentPayment,min:0,max:2000,divisions: 2000,label: _currentPayment.toString(), onChanged: (double value) {
                        setState(() {
                          _currentPayment = value;
                        });
                      })
                    ],
                  );
                })
          ],
        ),
      ),
    ];
    return steps;
  }
  /*hizmetVerFonk() {
    setState(() {});
    return showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (BuildContext context, setState) {
          //Form(key: _formkey, child: Column,)
          return _hizmetVerStepper(setState);

        });
      },
    );
  }*/
  void continueButton(int activeStep) {
    if (_formkey[activeStep].currentState.validate()) {
      if (activeStep < _stepListInit(setState).length-1) {
        _formkey[activeStep].currentState.save();
        debugPrint(_activeStep.toString());
        activeStep++;
        setState(() {
          _activeStep = activeStep;
          debugPrint("active step" + _activeStep.toString());
        });
      } else {
        _formkey[activeStep].currentState.save();
        final hizmetModel=Provider.of<HizmetModel>(context,listen:false);
        //hizmetModel.createHizmet(hizmetID:"1",title:"Uygulama",category: categoryPath[0],subCategory: categoryPath[1],publisher: "0Sck4MaFeQMTa4nnv3BU12Z6vP83",detail: _aciklama.text,address: _address.text,payment:1000.0);
        hizmetModel.createHizmet(hizmetID:"3",title:"Deneme",category: categoryPath[0],subCategory: categoryPath[1],publisher: "0Sck4MaFeQMTa4nnv3BU12Z6vP83",detail: _aciklama.text,address: _address.text,payment:_currentPayment);
      }
    } else {
      showToast(
          context,
          "Kullanım koşullarını kabul etmediğiniz için üyelik işlemine devam edemiyoruz.",
          Colors.red);
    }
  }
}
