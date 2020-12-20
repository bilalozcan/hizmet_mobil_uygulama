import 'package:flutter/material.dart';
import 'package:hizmet_mobil_uygulama/common_widget/SocialLoginButton.dart';
import 'package:hizmet_mobil_uygulama/models/User_.dart';
import 'package:hizmet_mobil_uygulama/ui/LoginPage.dart';
import 'package:hizmet_mobil_uygulama/utils/ToastMessage.dart';
import 'package:hizmet_mobil_uygulama/viewmodel/user_model.dart';
import 'package:provider/provider.dart';
import 'package:hizmet_mobil_uygulama/ui/SignUpPage.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  void _signInWithGoogle(BuildContext context) async {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    User_ _user = await _userModel.signInWithGoogle();
    if (_user != null) {
      showToast(context, "Hoşgeldiniz ${_user.name}", Colors.green);
    }
  }

  void _signInWithEmailAndPassword(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => LoginPage(),
      ),
    );
  }

  void _signUpWithEmailAndPassword(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => SignUp(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HİZMET"),
        elevation: 0,
      ),
      backgroundColor: Colors.grey.shade200,
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Oturum Açın",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
            ),
            SizedBox(
              height: 8,
            ),
            SocialLoginButton(
              butonText: "Gmail ile Giriş Yap",
              textColor: Colors.black87,
              butonColor: Colors.white,
              onPressed: () => _signInWithGoogle(context),
            ),
            SocialLoginButton(
              onPressed: () => _signInWithEmailAndPassword(context),
              butonIcon: Icon(
                Icons.email,
                color: Colors.white,
                size: 32,
              ),
              butonText: "Email ve Şifre ile Giriş yap",
            ),
            SocialLoginButton(
              onPressed: () => _signUpWithEmailAndPassword(context),
              butonColor: Colors.deepOrange,
              butonIcon: Icon(
                Icons.email,
                color: Colors.white,
                size: 32,
              ),
              butonText: "Hesabın Yok mu? Hemen Kayıt ol",
            ),
          ],
        ),
      ),
    );
  }
}
