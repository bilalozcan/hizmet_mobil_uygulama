import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hizmet_mobil_uygulama/CarouselSlider.dart';
import 'package:hizmet_mobil_uygulama/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hizmet_mobil_uygulama/models/User.dart';


/*Tüm firebase verilerini uygulama açılırken almak doğru olmaz */
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool showUpdateNotes;
  Map<String,Object> currentUser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showUpdateNotes=true;
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        firebaseAuth.signOut();
        Navigator.pop(context);
        return true;
      },
      child: Material(
        child:CarouselSlider(photoPaths:["assets/carouselPhotos/photo1.jpg","assets/carouselPhotos/photo2.jpg","assets/carouselPhotos/photo3.jpg"]),
        ),
      );
  }
  updateNotes() {
  return Column(
    children: [
      IconButton(icon:Icon(Icons.close),onPressed: () {setState(() {
        showUpdateNotes=false;
      });},),
      Dialog(child:CarouselSlider(photoPaths:["assets/carouselPhotos/photo1.jpg","assets/carouselPhotos/photo2.jpg","assets/carouselPhotos/photo3.jpg"])),
    ],
  );
  }
/*Dialog(child: CarouselSlider(photoPaths:["assets/carouselPhotos/photo1.jpg","assets/carouselPhotos/photo2.jpg","assets/carouselPhotos/photo3.jpg"]),),*/
}
