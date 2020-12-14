import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hizmet_mobil_uygulama/mainFdu.dart';
import 'package:shared_preferences/shared_preferences.dart';

dialogMessageForExit(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Hesaptan Çıkış Yapmak İstediğinize Emin Misiniz?"),
          actions: [
            CupertinoButton(
              child: Text("EVET"),
              onPressed: () async{
                firebaseAuth.signOut();
                SharedPreferences value=await SharedPreferences.getInstance();
                value.setInt("login",0);
                Navigator.of(context).pushNamedAndRemoveUntil("/SignIn", (route) => false);
              },
            ),
            CupertinoButton(
              child: Text("HAYIR"),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
            )
          ],
        );
      });
}
