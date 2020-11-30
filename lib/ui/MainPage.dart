import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:hizmet_mobil_uygulama/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hizmet_mobil_uygulama/models/User.dart';


/*Tüm firebase verilerini uygulama açılırken almak doğru olmaz */
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Map<String,Object> currentUser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
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
          centerTitle: true,
          title: Text("HİZMET", style:GoogleFonts.swankyAndMooMoo(fontSize: 48)),
        ),
        body:Profile(),
        ),
      );
  }
  Profile()
  {
    return Container(child:ListTile(title:Text(""),),);
  }
}
