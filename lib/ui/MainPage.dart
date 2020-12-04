import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hizmet_mobil_uygulama/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hizmet_mobil_uygulama/models/CarouselSlider.dart';
import 'package:hizmet_mobil_uygulama/models/User.dart';
import 'package:hizmet_mobil_uygulama/utils/DialogMessage.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    _currentNavigationBarIndex=0;
    activeUser();
  }

  activeUser()async
  {
    SharedPreferences value=await SharedPreferences.getInstance();
    if(firebaseAuth.currentUser.email!=null) {
      setState(() {
        value.setInt("${firebaseAuth.currentUser.email}", 1);
      });
    }
  }

  exit()
  {
    dialogMessageForExit(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        dialogMessageForExit(context);
        return true;
      },
      child: Scaffold(
        drawer: Drawer(child:Column(children: [DrawerHeader(child: Text("${firebaseAuth.currentUser.email}"),),ListTile(title:Text("Deneme") ,)],)),
        bottomNavigationBar: BottomNavigationBar(onTap:(currentIndex){
          setState(() {
            _currentNavigationBarIndex=currentIndex;
          });
        },
          currentIndex: _currentNavigationBarIndex,items: [BottomNavigationBarItem(icon:Icon(Icons.account_circle),label: "Profil"),BottomNavigationBarItem(icon:Icon(Icons.library_add_check_sharp),label: "İlanlarım"),BottomNavigationBarItem(icon:Icon(Icons.list_alt_sharp),label:"Kategoriler")],),
        appBar: AppBar(
          title: Text("HİZMET"),
          centerTitle: true,
        ),
        body:Pages(_currentNavigationBarIndex),
      ),
    );
  }

  Pages(int currentNavigationBarIndex) {
    switch(_currentNavigationBarIndex)
    {
      case 0:
        return Text("Profil Sayfası");
      case 1:
        return Text("İlanlar Sayfası");
      case 2:
        return Text("Kategori Sayfası");
    }
  }
/*Dialog(child: CarouselSlider(photoPaths:["assets/carouselPhotos/photo1.jpg","assets/carouselPhotos/photo2.jpg","assets/carouselPhotos/photo3.jpg"]),),*/
}
