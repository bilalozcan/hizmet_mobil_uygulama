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
      User_ _girisYapanUser = await _userModel.signInWithEmailandPassword(
          _email.text, _password.text);

    } on PlatformException catch (e) {
      showToast(context, "Oturum Açma Hatası. ${e.code}", Colors.red.shade700);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserModel>(context, listen: true);
    if (_userModel.user != null) {
      Future.delayed(Duration(milliseconds: 1), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
        );
      });
    }
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
                              ? Icons.visibility
                              : Icons.visibility_off,
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
