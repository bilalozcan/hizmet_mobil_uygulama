import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hizmet_mobil_uygulama/common_widget/SocialLoginButton.dart';
import 'package:hizmet_mobil_uygulama/mainFdu.dart';
import 'package:hizmet_mobil_uygulama/models/User.dart';
import 'package:hizmet_mobil_uygulama/models/User_.dart';
import 'package:hizmet_mobil_uygulama/ui/resetPassword.dart';
import 'package:hizmet_mobil_uygulama/viewmodel/user_model.dart';
import 'package:provider/provider.dart';

import 'SignUp.dart';

class EmailveSifreSignPage extends StatefulWidget {
  @override
  _EmailveSifreSignPageState createState() => _EmailveSifreSignPageState();
}

class _EmailveSifreSignPageState extends State<EmailveSifreSignPage> {
  String _email, _sifre;

  final _formKey = GlobalKey<FormState>();

  void _formSubmit() async {
    _formKey.currentState.save();
    //debugPrint("email :" + _email + " şifre:" + _sifre);

    final _userModel = Provider.of<UserModel>(context);
      try {
        User_ _olusturulanUser =
        await _userModel.createUserWithEmailandPassword(_email, _sifre);
        /* if (_olusturulanUser != null)
          print("Oturum açan user id:" + _olusturulanUser.userID.toString());*/
      } on PlatformException catch (e) {
        /*PlatformDuyarliAlertDialog(
          baslik: "Kullanıcı Oluşturma HATA",
          icerik: Hatalar.goster(e.code),
          anaButonYazisi: 'Tamam',
        ).goster(context);*/
      }
  }


  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserModel>(context);

    if (_userModel.user != null) {
      Future.delayed(Duration(milliseconds: 1), () {
        Navigator.of(context).popUntil(ModalRoute.withName("/"));
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Kayıt"),
      ),
      body: _userModel.state == ViewState.Idle
          ? SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    //initialValue: "emre@emre.com",
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      errorText: _userModel.emailHataMesaji != null
                          ? _userModel.emailHataMesaji
                          : null,
                      prefixIcon: Icon(Icons.mail),
                      hintText: 'Email',
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (String girilenEmail) {
                      _email = girilenEmail;
                    },
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    //initialValue: "password",
                    obscureText: true,
                    decoration: InputDecoration(
                      errorText: _userModel.sifreHataMesaji != null
                          ? _userModel.sifreHataMesaji
                          : null,
                      prefixIcon: Icon(Icons.lock),
                      hintText: 'Sifre',
                      labelText: 'Sifre',
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (String girilenSifre) {
                      _sifre = girilenSifre;
                    },
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  SocialLoginButton(
                    butonText: "Kayıt ol",
                    butonColor: Colors.purple,
                    radius: 10,
                    onPressed: () => _formSubmit(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              )),
        ),
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
/*class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String _email;
  String _password;
  bool _obscureText;
  var formKey;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _obscureText = true;
    formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        exit(0);
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Giriş"),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("HİZMET",
                        style: GoogleFonts.swankyAndMooMoo(fontSize: 48)),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: "E-mail",
                          labelStyle: TextStyle(color: Colors.blue[700]),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          )),
                      onSaved: (email) {
                        setState(() {
                          this._email = email;
                        });
                      },
                    ),
                    SizedBox(height: 25),
                    TextFormField(
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.remove_red_eye,
                            color: _obscureText == true
                                ? Colors.black
                                : Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                        labelText: "Şifre",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                      onSaved: (password) {
                        setState(() {
                          this._password = password;
                        });
                      },
                    ),
                    CupertinoButton(
                      child: Text(
                        "Giriş yap",
                      ),
                      onPressed: enterButton,
                    ),
                    InkWell(
                      child: Text(
                        "Şifreni mi Unuttun?",
                        style: TextStyle(color: Colors.blue),
                      ),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResetPassword(),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    CupertinoButton(
                      color: Colors.white,
                      child: Text("Yeni Hizmet Hesabı Oluştur",
                          style: TextStyle(color: Colors.green)),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                LoginPage(firebaseAuth: firebaseAuth)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  enterButton() {
    if (formKey.currentState.validate())
      setState(() {
        formKey.currentState.save();
        debugPrint(this._email);
        debugPrint(this._password);
      });
    HizmetUser user = HizmetUser.SignIn(
        context: context,
        firebaseAuth: firebaseAuth,
        email: this._email,
        password: this._password);
    user.userSignIn(context);
  }
}
*/

