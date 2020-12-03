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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    activeUser();
  }

  activeUser()async
  {
    SharedPreferences value=await SharedPreferences.getInstance();
    value.setInt("${firebaseAuth.currentUser.email}",1);
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
        drawer: Drawer(child:DrawerHeader(child:ListView.builder(itemCount: 10,itemBuilder: (context,index)
          {
            if(index%2==0)
              return Divider();
            return
                Row(mainAxisAlignment:MainAxisAlignment.center,children: [InkWell(onTap: (){
                  dialogMessageForExit(context);
                },child:Text("ÇIKIŞ YAP"))],);
          },))),
        appBar: AppBar(
          title: Text("HİZMET"),
        ),
        body: Text("${firebaseAuth.currentUser.email}"),
      ),
    );
  }
/*Dialog(child: CarouselSlider(photoPaths:["assets/carouselPhotos/photo1.jpg","assets/carouselPhotos/photo2.jpg","assets/carouselPhotos/photo3.jpg"]),),*/
}
