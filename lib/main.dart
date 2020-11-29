import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hizmet_mobil_uygulama/ui/SignIn.dart';
import 'package:hizmet_mobil_uygulama/ui/loginPage.dart';
import 'package:firebase_core/firebase_core.dart';

import 'ui/MainPage.dart';
/*Bu değişkenlerin mainden başlayıp diğer sınıflara parametre olarak gitmesi yerine her yerden erişeblir
olması adına global olması daha iyi olur gibi. Kullanıcı bir anda birden fazla kez bu değişkenlere istek atamayacağı için çakışma durumunun olmayacağını
tahmin ediyorum
 */
FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
FirebaseAuth firebaseAuth=FirebaseAuth.instance;
var collection=firebaseFirestore.collection("hizmetAlanUsers");
var collectionHizmetVeren=firebaseFirestore.collection("hizmetVerenUsers");

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  collection.snapshots().listen((event)async {debugPrint( event.docs.toString());});
/*Bu listener sayesinde veri geldiğinde uygulamada direkt okumamız sağlanır*/
  runApp(MyApp(firebaseAuth: firebaseAuth,));
}

class MyApp extends StatefulWidget {
  FirebaseAuth _firebaseAuth;
  MyApp({@required FirebaseAuth firebaseAuth})
  {
    this._firebaseAuth=firebaseAuth;
  }
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home:SignIn(),theme: ThemeData(primarySwatch: Colors.green),debugShowCheckedModeBanner: false,);
  }
}
