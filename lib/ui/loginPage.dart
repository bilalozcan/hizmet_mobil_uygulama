import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hizmet_mobil_uygulama/main.dart';
import 'package:platform_date_picker/platform_date_picker.dart';

import '../models/User.dart';

//Hizmet alacak kisiye ait kayıt ekranı
class LoginPage extends StatefulWidget {
  FirebaseAuth _firebaseAuth;

  LoginPage({@required firebaseAuth}) {
    this._firebaseAuth = firebaseAuth;
  }

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  HizmetUser _user;
  List<Step> _stepList;
  int _activeStep = 0;
  String _name;
  String _surname;
  String _email;
  String _password;
  String _gender;
  bool _accept;

  List<GlobalKey<FormState>> _formKeys = [];

  String get password => _password;

  set password(String newPassword) {
    this._password = newPassword;
  }

  String get name => _name;

  set name(String newName) {
    this._name = newName;
  }

  String get email => _email;

  set email(String newEmail) {
    this._email = newEmail;
  }

  @override
  void initState() {
    super.initState();
    _formKeys.add(new GlobalKey<FormState>());
    _formKeys.add(new GlobalKey<FormState>());
    _formKeys.add(new GlobalKey<FormState>());
  }

  @override
  Widget build(BuildContext context) {
    _stepList = _stepListInit();
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text("Hizmet Kayit"),
          backgroundColor: Colors.green),
      body: Container(
        color: Colors.greenAccent,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(child: _loginStepper()),
      ),
    );
  }

  _loginStepper() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.green,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
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
                child: Text(
                    _activeStep < _stepList.length - 1 ? "İlerle" : "Bitir"),
                onPressed: onStepContinue,
              ),
            ],
          );
        },
        currentStep: _activeStep,
        onStepContinue: () async {
          if (_activeStep < _stepList.length - 1)
            continueButton(_activeStep);
          else if (_activeStep == _stepList.length - 1) {
            debugPrint(
                "İsim:$_name   Soyisim:$_surname  Sifre:$_password  Cinsiyet:$_gender ");
            _user = HizmetUser(
                context: context,
                firebaseAuth: widget._firebaseAuth,
                name: _name,
                surname: _surname,
                email: _email,
                password: _password,
                gender: _gender);
            await _user.userLogIn();
          }
        },
        onStepCancel: () {
          setState(() {
            if (_activeStep != 0)
              _activeStep--;
            else
              debugPrint("ilk asamadaki cancel tiklandi");
          });
        },
        type: StepperType.horizontal,
        steps: _stepListInit(),
      ),
    );
  }

  List<Step> _stepListInit() {
    List<String> genders = ["Erkek", "Kadın", "Diğer"];
    List<Step> steps = [
      Step(
        isActive: _activeStep == 0 ? true : false,
        state: _stepStateController(0),
        title: Text(
          _activeStep == 0 ? "Kişisel Bilgiler" : "Kisi...",
        ),
        content: Column(
          children: [
            Form(
              key: _formKeys[0],
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "İsim", border: OutlineInputBorder()),
                    validator: (name) {
                      String error = "";
                      if (name == "") {
                        error = "İsim kısmı boş geçilemez";
                        return error;
                      }
                      if (name.contains(RegExp("[0-9]"))) {
                        error = "Lutfen gecerli bir isim giriniz";
                        return error;
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onSaved: (name) {
                      this._name = name;
                    },
                  ),
                  SizedBox(height: 5),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Soy isim", border: OutlineInputBorder()),
                    validator: (surname) {
                      String error = "";
                      if (surname == "") return "Soy isim kısmı boş geçilemez";
                      if (surname.contains(RegExp("[0-9]"))) {
                        error += "Lutfen gecerli bir soy isim giriniz";
                        return error;
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onSaved: (surname) {
                      setState(() {
                        this._surname = surname;
                      });
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      Step(
        state: _stepStateController(1),
        isActive: _activeStep == 1 ? true : false,
        title: Text(_activeStep == 1 ? "Kullanıcı Bilgileri" : "Kullanı..."),
        content: Form(
          key: _formKeys[1],
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "E-Mail",
                    border: OutlineInputBorder(),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                  ),
                  onSaved: (email) {
                    setState(() {
                      this._email = email;
                    });
                  },
                ),
                SizedBox(height: 5),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Şifre",
                    border: OutlineInputBorder(),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                  ),
                  validator: (password) {
                    if (password.length < 6)
                      return "Şifrenizin 6 karakterden daha büyük olması gerekmektedir.";
                    if (!password.contains(RegExp("[0-9]")) ||
                        !password.contains(RegExp("[a-z]")) ||
                        !password.contains(RegExp("[A-Z]")))
                      return "Şifreniz en az bir sayı,bir büyük harf ve bir küçük harf içermelidir";
                    return null;
                  },
                  onChanged: (password) {
                    setState(() {
                      this.password = password;
                    });
                    debugPrint(this.password);
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                SizedBox(height: 5),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Şifreyi Onayla",
                    border: OutlineInputBorder(),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                  ),
                  validator: (rePassword) {
                    if (rePassword != this.password) {
                      debugPrint(password);
                      return "İki şifre birbiriyle eşleşmiyor";
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ],
            ),
          ),
        ),
      ),
      Step(
        state: _stepStateController(2),
        isActive: _activeStep == 2 ? true : false,
        title: Text(_activeStep == 2 ? "Diğer Bilgiler" : "Diğer..."),
        content: Column(
          children: [
            Form(
              key: _formKeys[2],
              child: Column(
                children: [
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                        labelText: "Cinsiyet",
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        border: OutlineInputBorder(),
                        hintText: "Cinsiyet Seçimi"),
                    elevation: 16,
                    value: _gender,
                    onChanged: (value) {
                      setState(() {
                        _gender = value;
                      });
                    },
                    items: genders.map(
                      (gender) {
                        return DropdownMenuItem(
                          value: gender,
                          child: Row(
                            children: [
                              Text(gender),
                              Icon(
                                Icons.person,
                                color: gender == genders[0]
                                    ? Colors.blue
                                    : gender == genders[1]
                                        ? Colors.pink
                                        : Colors.grey,
                              )
                            ],
                          ),
                        );
                      },
                    ).toList(),
                  ),
                  CheckboxListTile(
                      value: _accept,
                      onChanged: (value) {
                        setState(() {
                          _accept = value;
                        });
                      },
                      title: InkWell(
                        onTap: () {
                          showCupertinoDialog(
                              context: context,
                              builder: (context) {
                                return CupertinoAlertDialog(
                                  content: Container(child:Text("İşte siz ilan veriyonuz falan filan. Armut ayağını denk alsın")),
                                  title: Text("Kullanım koşulları"),
                                );
                              });
                        },
                        child: Text(
                          "Kullanım koşullarını okudum ve kabul ediyorum",
                          style: TextStyle(fontSize: 13),
                        ),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    ];
    return steps;
  }

  void continueButton(int activeStep) {
    if (_formKeys[activeStep].currentState.validate()) {
      setState(() {
        _formKeys[activeStep].currentState.save();
        if (activeStep < _stepList.length - 1) {
          debugPrint(_activeStep.toString());
          activeStep++;
          _activeStep = activeStep;
        }
      });
    }
  }

  StepState _stepStateController(int step) {
    if (step == _activeStep)
      return StepState.editing;
    else if (step < _activeStep)
      return StepState.complete;
    else
      return StepState.error;
  }
}
