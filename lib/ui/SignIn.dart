import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hizmet_mobil_uygulama/main.dart';
import 'package:hizmet_mobil_uygulama/models/User.dart';

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
        title: Text("Giris"),
      ),
      body: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .height,
        color: Colors.greenAccent,
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                /* onSaved ve validator metodları eklenecek*/
                TextFormField(
                  decoration: InputDecoration(
                      labelText: "E-posta adresi",
                      border: OutlineInputBorder()),
                  onSaved: (email) {
                    setState(() {
                      this._email = email;
                    });
                  },
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Şifre",
                    border: OutlineInputBorder(),
                    suffix: IconButton(
                      icon: Icon(Icons.remove_red_eye_rounded),
                      onPressed: () {},
                    ),
                  ),
                  onSaved: (password) {
                    setState(() {
                      this._password = password;
                    });
                  },
                ),
                RaisedButton(
                  child: Text("Giriş yap"),
                  onPressed: enterButton,
                )
              ],
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
    HizmetUser user=HizmetUser.SignIn(context: context, firebaseAuth: firebaseAuth, email: this._email, password: this._password);
    user.userSignIn(context);

  }
}
