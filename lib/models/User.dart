import 'dart:collection';

//import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hizmet_mobil_uygulama/models/CarouselSlider.dart';
import 'package:hizmet_mobil_uygulama/utils/ToastMessage.dart';
import 'package:hizmet_mobil_uygulama/main.dart';
import 'package:hizmet_mobil_uygulama/ui/MainPage.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../ui/SignIn.dart';

class HizmetUser {
  FirebaseAuth _firebaseAuth;
  String _name;
  String _surname;
  String _email;
  String _password;
  String _gender;
  BuildContext _context;
  DateTime _dateOfBirth;
  int _firstTime=0;
  HashMap<String, dynamic> userMap = HashMap<String, dynamic>();

  DateTime get dateOfBirth => _dateOfBirth;

  set dateOfBirth(DateTime value)
  {
    _dateOfBirth=value;
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
      @required String gender,
      @required DateTime dateOfBirth}) {
    this._firebaseAuth = firebaseAuth;
    this._name = name;
    this._surname = surname;
    this._email = email;
    this._password = password;
    this._gender = gender;
    this._context = context;
    this._dateOfBirth = dateOfBirth;
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
              "E-posta düzeni hatalı ya da bu E-posta adresi daha önceden alınmış durumda.\n  Lütfen yeni bir e-posta adresi giriniz",
              Colors.red));
      User currentUser = _credential.user;
      addToFirebaseFirestore(false);
      await currentUser.sendEmailVerification();
      if (_firebaseAuth.currentUser != null) {
        _firebaseAuth.signOut();
        showToast(
            _context,
            "Doğrulama E-postası $email adresine gönderilmiştir. Lütfen kontrol ediniz",
            Colors.green);
        Navigator.push(
                _context, MaterialPageRoute(builder: (context) => SignIn()));
      }
    }
  }

  userSignIn(BuildContext context) async {
    if (_firebaseAuth.currentUser == null) {
      User _user = (await _firebaseAuth
              .signInWithEmailAndPassword(
                  email: this.email, password: this.password)
              .catchError((onError) {
        showToast(
            _context,
            "E-posta adresi veya şifre hatalı. Lütfen tekrar deneyiniz",
            Colors.red);
      })).user;
      if (_user == null) debugPrint("Böyle bir kullanıcı sistemde yok ");
      if (_user.emailVerified) {
        addToFirebaseFirestore(true);
        SharedPreferences value=await SharedPreferences.getInstance();
        _firstTime=value.getInt("${this._email}");
        debugPrint("_firstTime sayisi  $_firstTime");
        if(_firstTime!=null) {
          Navigator.push(
              _context, MaterialPageRoute(builder: (_context) => MainPage()));
        }
        else {
          Navigator.push(
              _context, MaterialPageRoute(builder: (_context) =>
              CarouselSlider(photoPaths: [
                "assets/carouselPhotos/photo1.jpg",
                "assets/carouselPhotos/photo2.jpg",
                "assets/carouselPhotos/photo3.jpg"
              ],email: this._email,)));
        }
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
  addToFirebaseFirestore(bool flag) {
    var doc = collection.doc(this.email);
    doc.get().then((value) async {
      if (value.data() == null) {
        debugPrint(this.email);
        if (flag == false) {
          userMap["name"] = _name;
          userMap["surname"] = _surname;
          userMap["gender"] = _gender;
          userMap["email"] = _email;
          userMap["flag"] = flag;
        }
      } else if (value.data() != null && flag == true) {
        userMap["flag"] = flag;
      }
      await doc.set(userMap, SetOptions(merge: true)).catchError((onError) =>
          showToast(
              this._context,
              "Kullanıcı,veritabanına kaydedilirken bir sorunla karşılaşıldı",
              Colors.red));
    });
  }

  /*addHizmetVerenToFirebaseFirestore(bool flag) async {
    var doc = collectionHizmetVeren.doc(this.email);
    if (flag == false) {
      userMap["name"] = _name;
      userMap["surname"] = _surname;
      userMap["gender"] = _gender;
      userMap["email"] = _email;
      userMap["flag"] = flag;
      userMap["city"] = _hizmetVerenSehir;
      await doc.set(userMap).catchError((onError) => showToast(
          this._context,
          "Kullanıcı,veritabanına kaydedilirken bir sorunla karşılaşıldı",
          Colors.red));
    } else if (flag == true) {
      userMap["flag"] = flag;
      await doc.set(userMap, SetOptions(merge: true)).catchError((onError) =>
          showToast(
              this._context,
              "Kullanıcı,veritabanına kaydedilirken bir sorunla karşılaşıldı",
              Colors.red));
    }
  }*/
}
