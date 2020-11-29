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

class HizmetUser {
  FirebaseAuth _firebaseAuth;
  String _name;
  String _surname;
  String _email;
  String _password;
  String _gender;
  String _hizmetVerenSehir;
  BuildContext _context;
  HashMap<String, dynamic> userMap = HashMap<String, dynamic>();

  String get hizmetVerenSehir => _hizmetVerenSehir;

  set hizmetVerenSehir(String value) {
    _hizmetVerenSehir = value;
  }
  String get password => _password;

  set password(String value) {
    _password = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
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

  /* Eğer kullanıcı sisteme ilk defa kayıt edilecekse constructorda bulunan tüm parametrelerin
   girilmesi zorunludur. Giriş yapacak kullanıcı için ayrı bir constructor da yapılabilir.
   */

  HizmetUser(
      {@required BuildContext context,
      @required firebaseAuth,
      @required String name,
      @required String surname,
      @required String email,
      @required String password,
      @required String gender}) {
    this._firebaseAuth = firebaseAuth;
    this._name = name;
    this._surname = surname;
    this._email = email;
    this._password = password;
    this._gender = gender;
    this._context = context;
  }
  HizmetUser.HizmetVeren({@required BuildContext context,
      @required firebaseAuth,
      @required String name,
      @required String surname,
      @required String email,
      @required String password,
      @required String gender,
      @required String hizmetVerenSehir}){
  this._firebaseAuth = firebaseAuth;
  this._name = name;
  this._surname = surname;
  this._email = email;
  this._password = password;
  this._gender = gender;
  this._context = context;
  this._hizmetVerenSehir=hizmetVerenSehir;

  }

  HizmetUser.SignIn({
    @required BuildContext context,
    @required firebaseAuth,
    @required String email,
    @required String password,
  }) {
    this._context = context;
    this._firebaseAuth = firebaseAuth;
    this._email = email;
    this._password = password;
  }

  userLogIn() async {
    if (_name == null || _gender == null || _surname == null) {
      showToast(this._context, "İsim,soy isim ve cinsiyet değerleri boş olamaz",
          Colors.red);
    } else {
      UserCredential _credential = await _firebaseAuth
          .createUserWithEmailAndPassword(
              email: this.email, password: this.password)
          .catchError((onError) => showToast(
              _context,
              "Bu e mail adresi zaten alınmış durumda lütfen başka bir mail adresi ile tekrar deneyiniz",
              Colors.red));
      User currentUser = _credential.user;
      if(this._hizmetVerenSehir==null)
      addToFirebaseFirestore(false);
      else
        addHizmetVerenToFirebaseFirestore(false);
      await currentUser.sendEmailVerification();
      if (_firebaseAuth.currentUser != null) {
        _firebaseAuth.signOut();
        showToast(_context,"Doğrulama E-postası $email adresine gönderilmiştir. Lütfen kontrol ediniz",Colors.green);
        Navigator.push(
                _context, MaterialPageRoute(builder: (context) => SignIn()))
            .then((value) => debugPrint("aaa" + value.toString()));
      }
    }
  }

  userSignIn(BuildContext context) async {
    if (_firebaseAuth.currentUser == null) {
      User _user = (await _firebaseAuth
              .signInWithEmailAndPassword(
                  email: this.email, password: this.password)
              .catchError((onError) { /*if(
        onError.toString() ==
                "[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted." ||
            onError.toString() ==
                "[firebase_auth/user-not-found] The password is invalid or the user does not have a password.")*/
          showToast(
              _context,
              "E-posta adresi veya şifre hatalı. Lütfen tekrar deneyiniz",
              Colors.red);
      }))
          .user;
      if (_user == null) debugPrint("Böyle bir kullanıcı sistemde yok ");
      if (_user.emailVerified) {
        if(this._hizmetVerenSehir==null)
        addToFirebaseFirestore(true);
        else
          addHizmetVerenToFirebaseFirestore(true);
        Navigator.push(
            _context, MaterialPageRoute(builder: (_context) => MainPage()));
      } else if (!_user.emailVerified) {
        _firebaseAuth.signOut();
        showToast(
            _context,
            "E-posta adresi veya şifre yanlış. Lütfen tekrar deneyiniz. Hesap bilgilerinden eminseniz lütfen doğrulama mailini onayladığınızdan emin olun",
            Colors.red);
      }
    }
  }

  /* Kullanıcı auth ve e mail işlemlerini tamamladıktan sonra fireBase'e eklenir */
  addToFirebaseFirestore(bool flag) async {
    var doc=collection.doc(this.email);
    if(flag==false) {
      userMap["name"] = _name;
      userMap["surname"] = _surname;
      userMap["gender"] = _gender;
      userMap["email"] = _email;
      userMap["flag"] = flag;
      await doc.set(userMap).catchError((onError) => showToast(
          this._context,
          "Kullanıcı,veritabanına kaydedilirken bir sorunla karşılaşıldı",
          Colors.red));
    }
    else if(flag==true)
      {
        userMap["flag"]=flag;
        await doc.set(userMap,SetOptions(merge: true)).catchError((onError) => showToast(
            this._context,
            "Kullanıcı,veritabanına kaydedilirken bir sorunla karşılaşıldı",
            Colors.red));
      }/*Kullanıcı her giriş yaptığında veri tabanına kaydediyor bunu engelle */
  }
  addHizmetVerenToFirebaseFirestore(bool flag) async
  {
  var doc=collectionHizmetVeren.doc(this.email);
  if(flag==false) {
    userMap["name"] = _name;
    userMap["surname"] = _surname;
    userMap["gender"] = _gender;
    userMap["email"] = _email;
    userMap["flag"] = flag;
    userMap["city"]=_hizmetVerenSehir;
    await doc.set(userMap).catchError((onError) => showToast(
        this._context,
        "Kullanıcı,veritabanına kaydedilirken bir sorunla karşılaşıldı",
        Colors.red));
  }
  else if(flag==true)
  {
    userMap["flag"]=flag;
    await doc.set(userMap,SetOptions(merge: true)).catchError((onError) => showToast(
        this._context,
        "Kullanıcı,veritabanına kaydedilirken bir sorunla karşılaşıldı",
        Colors.red));
  }
  }
}
