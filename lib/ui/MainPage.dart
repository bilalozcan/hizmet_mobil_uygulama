import 'dart:collection';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hizmet_mobil_uygulama/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hizmet_mobil_uygulama/models/CarouselSlider.dart';
import 'package:hizmet_mobil_uygulama/models/User.dart';
import 'package:hizmet_mobil_uygulama/utils/DialogMessage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ProfilePage.dart';

/*Tüm firebase verilerini uygulama açılırken almak doğru olmaz */
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Map<String, Object> currentUser;
  int _currentNavigationBarIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentNavigationBarIndex = 0;
    activeUser();
  }

  activeUser() async {
    SharedPreferences value = await SharedPreferences.getInstance();
    if (firebaseAuth.currentUser.email != null) {
      setState(() {
        value.setInt("login", 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        exit(0);
      },
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          onTap: (currentIndex) {
            setState(() {
              _currentNavigationBarIndex = currentIndex;
            });
          },
          currentIndex: _currentNavigationBarIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle), label: "Anasayfa"),
            BottomNavigationBarItem(
                icon: Icon(Icons.library_add_check_sharp,size: 55), label: "Hizmet Ver"),
            BottomNavigationBarItem(
                icon: Icon(Icons.library_add_check_sharp,size: 55), label: "Hizmetlerim"),
            BottomNavigationBarItem(
                icon: Icon(Icons.list_alt_sharp), label: "Sohbet")
          ],
        ),
        appBar: AppBar(
          actions: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.account_circle),
                    iconSize: 48,
                    color: Colors.black,
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage()));
                    },
                  ),
                  Text(
                    "HİZMET",
                    style: GoogleFonts.hammersmithOne(fontSize: 35)
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    iconSize: 48,
                    color: Colors.black,
                    onPressed: (){
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        body: Pages(_currentNavigationBarIndex),
      ),
    );
  }

  Pages(int currentNavigationBarIndex) {
    switch (_currentNavigationBarIndex) {
      case 0:
        return ListView(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "İlanlar Sayfası",
              style: TextStyle(fontSize: 25, color: Colors.black),
            ),
            SizedBox(
              height: 300,
            ),
            Text(
              "İlanlar Sayfası",
              style: TextStyle(fontSize: 25, color: Colors.black),
            ),
            SizedBox(
              height: 300,
            ),
            Text(
              "İlanlar Sayfası",
              style: TextStyle(fontSize: 25, color: Colors.black),
            ),
            SizedBox(
              height: 300,
            ),
            Text(
              "İlanlar Sayfası",
              style: TextStyle(fontSize: 25, color: Colors.black),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "İlanlar Sayfası",
              style: TextStyle(fontSize: 25, color: Colors.black),
            ),
          ],
        );

      case 1:
        return Text("İlanlar Sayfası");
      case 2:
        return Text("Kategori Sayfası");
    }
  }
/*Dialog(child: CarouselSlider(photoPaths:["assets/carouselPhotos/photo1.jpg","assets/carouselPhotos/photo2.jpg","assets/carouselPhotos/photo3.jpg"]),),*/
}
