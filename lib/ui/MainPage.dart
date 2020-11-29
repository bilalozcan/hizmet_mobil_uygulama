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
    return WillPopScope(
      onWillPop: () async {
        firebaseAuth.signOut();
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Ana Sayfa"),
        ),
        body: Column(
          children: [
            Container(
              child: Text("Hoşgeldiniz Burası Ana Sayfa"),
            ),
            Container(
              child: Text(firebaseAuth.currentUser.email),
            ),
          ],
        ),
      ),
    );
  }
}
