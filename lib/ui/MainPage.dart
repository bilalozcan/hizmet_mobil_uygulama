import 'package:flutter/material.dart';
import 'package:hizmet_mobil_uygulama/main.dart';
/*Tüm firebase verilerini uygulama açılırken almak doğru olmaz */
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("AnaSayfa"),),body: Container(child: Text(firebaseAuth.currentUser.email),),);
  }
}
