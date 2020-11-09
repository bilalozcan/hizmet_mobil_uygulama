import 'dart:collection';
//import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hizmet_mobil_uygulama/utils/ToastMessage.dart';
import 'package:hizmet_mobil_uygulama/main.dart';
import 'package:hizmet_mobil_uygulama/ui/MainPage.dart';

import '../ui/SignIn.dart';

class HizmetUser{
  FirebaseAuth _firebaseAuth;
  String _firstname;
  String _surname;
  String _email;
  String _password;
  String _gender;
  String _username;
  BuildContext _context;

  String get password => _password;

  set password(String value) {
    _password = value;
  }

  String get firstname => _firstname;

  set firstname(String value) {
    _firstname = value;
  }

  String get surname => _surname;

  set surname(String value) {
    _surname = value;
  }

  String get gender => _gender;

  set gender(String value) {
    _gender = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }
  String get username => _username;

  set username(String value)
  {
    _username=value;
  }
  HizmetUser({@required BuildContext context,@required firebaseAuth,@required String firstname,@required String surname,@required String email,@required String password,@required String gender,@required String username})
  {
    this._firebaseAuth=firebaseAuth;
    this._firstname=firstname;
    this._surname=surname;
    this._email=email;
    this._password=password;
    this._gender=gender;
    this._username=username;
    this._context=context;
    debugPrint(this._email);
  }
  userLogIn()async
  {
    UserCredential _credential=await _firebaseAuth.createUserWithEmailAndPassword(email: this.email, password: this.password).catchError((onError)=>showToast(_context,"Bu e mail adresi zaten alınmış durumda lütfen başka bir mail adresi ile tekrar deneyiniz",Colors.red));
    User currentUser=_credential.user;
    await currentUser.sendEmailVerification();
    if(_firebaseAuth.currentUser !=null) {
      _firebaseAuth.signOut();
      Navigator.push(
          _context, MaterialPageRoute(builder: (context) => SignIn())).then((value) =>  debugPrint("aaa"+value.toString()));
    }
  }
  userSignIn(BuildContext context)async
  {
    if(_firebaseAuth.currentUser==null) {
        User _user = (await _firebaseAuth.signInWithEmailAndPassword(
            email: this.email, password: this.password).catchError((onError){ if(onError.toString()=="[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted." || onError.toString()=="[firebase_auth/user-not-found] The password is invalid or the user does not have a password.") showToast(_context, "E-posta adresi veya şifre yanlış. Lütfen tekrar deneyiniz", Colors.red);})).user;
        if (_user == null)
          debugPrint("Böyle bir kullanıcı sistemde yok ");
        if (_user.emailVerified) {
          addToFirebaseFirestore();
          Navigator.push(
              _context, MaterialPageRoute(builder: (_context) => MainPage()));
        }
        else if (!_user.emailVerified) {
          _firebaseAuth.signOut();
          showToast(_context,"E-posta adresi veya şifre yanlış. Lütfen tekrar deneyiniz. Hesap bilgilerinden eminseniz lütfen doğrulama mailini onayladığınızdan emin olun",Colors.red);
        }
    }
  }

  /* Kullanıcı auth ve e mail işlemlerini tamamladıktan sonra fireBase'e eklenir */
  addToFirebaseFirestore() async
  {
    HashMap<String, dynamic> userMap = HashMap<String, dynamic>();
    userMap["firstname"] = _firstname;
    userMap["surname"] = _surname;
    userMap["gender"] = _gender;
    userMap["email"] = _email;
    userMap["username"]=_username;
    await firebaseFirestore.collection("hizmetAlanUsers").doc(this.username).set(userMap);
  }
}
