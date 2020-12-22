import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hizmet_mobil_uygulama/locator.dart';
import 'package:hizmet_mobil_uygulama/mainFdu.dart';
import 'package:hizmet_mobil_uygulama/models/User_.dart';
import 'package:hizmet_mobil_uygulama/repository/UserRepository.dart';
import 'package:hizmet_mobil_uygulama/ui/HomePage.dart';
import 'package:hizmet_mobil_uygulama/utils/ToastMessage.dart';
import 'package:hizmet_mobil_uygulama/viewmodel/user_model.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool _obscureText = true;

  void login() async {
    _formKey.currentState.save();
    final _userModel = Provider.of<UserModel>(context, listen: false);
    try {
      await _userModel.signInWithEmailandPassword(_email.text, _password.text);
    } catch (e) {
      showToast(context, "E-posta veya şifre hatalı. Lütfen tekrar deneyiniz", Colors.red.shade700);
    }
  }
  loginDeneme() async {
    _formKey.currentState.save();
    final _userModel = Provider.of<UserModel>(context, listen: false);
    try {
      return FutureBuilder(future: _userModel.signInWithEmailandPassword(_email.text, _password.text),builder: (context,snapshot){
        if(!snapshot.hasData)
          return CircularProgressIndicator(backgroundColor: Colors.red,);
      },);
    }
    catch (e){

    }
  }

  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserModel>(context);
    Future.delayed(Duration(milliseconds:50),(){
      if (_userModel.user != null) {
        debugPrint("hadi bakim ibne"+_userModel.user.toString());
        Future.delayed(Duration(milliseconds: 100), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        });
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "HİZMET",
                    style: GoogleFonts.swankyAndMooMoo(fontSize: 48),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        labelText: "E-mail",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        )),
                    controller: _email,
                    //Validator
                  ),
                  SizedBox(height: 25),
                  TextFormField(
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText == true
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                      labelText: "Şifre",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    controller: _password,
                  ),
                  CupertinoButton(
                    child: Text(
                      "Giriş yap",
                    ),
                    onPressed: () => login(), //enterButton,
                  ),
                  InkWell(
                    child: Text(
                      "Şifreni mi Unuttun?",
                      style: TextStyle(color: Colors.blue),
                    ),
                    onTap: () {},
                  ),
                  SizedBox(height: 30),
                  CupertinoButton(
                    color: Colors.white,
                    child: Text("Yeni Hizmet Hesabı Oluştur",
                        style: TextStyle(color: Colors.green)),
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
