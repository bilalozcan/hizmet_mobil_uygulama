import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hizmet_mobil_uygulama/main.dart';
import 'package:hizmet_mobil_uygulama/models/User.dart';
import 'package:hizmet_mobil_uygulama/ui/resetPassword.dart';

import 'loginPage.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String _email;
  String _password;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Giris"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.greenAccent,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("HİZMET", style:GoogleFonts.swankyAndMooMoo(fontSize: 48)),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        labelText: "E-mail",
                        labelStyle: TextStyle(color: Colors.blue[700]),
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)),)),
                    onSaved: (email) {
                      setState(() {
                        this._email = email;
                      });
                    },
                  ),
                  SizedBox(height: 25),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Şifre",
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
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
                        builder: (context) =>
                            ResetPassword(),
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
                      MaterialPageRoute(builder: (context) => LoginPage(firebaseAuth: firebaseAuth)),
                    ),
                  )
                ],
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
