import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hizmet_mobil_uygulama/main.dart';
import 'package:hizmet_mobil_uygulama/models/User.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Giris"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.greenAccent,
        child: Center(
          child: Form(
            child: Column(
              children: [
                /* onSaved ve validator metodları eklenecek*/
                TextFormField(
                  decoration: InputDecoration(
                      labelText: "E-posta adresi", border: OutlineInputBorder()),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: "Şifre", border: OutlineInputBorder()),
                ),
                RaisedButton(
                  child: Text("Giriş yap"),
                  onPressed: () {
                    /*onSaved ve validator methodları yazıldıktan sonra dinamik bir yapıya geçiş yapılacak */
                    HizmetUser user = HizmetUser(
                        context: context,
                        firebaseAuth: firebaseAuth,
                        name: "Fatih",
                        surname: "Uzer",
                        email: "fatihdursunuzer@gmail.com",
                        password: "**********",
                        gender: "Erkek");
                    user.userSignIn(context);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
