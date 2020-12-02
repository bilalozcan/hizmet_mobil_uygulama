import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hizmet_mobil_uygulama/main.dart';

dialogMessageForExit(BuildContext context) {
  showDialog(
      context: context,
      builder: (contextt) {
        return AlertDialog(
          title: Text("Uygulamadan Çıkış Yapmak İstediğinize Emin Misiniz?"),
          actions: [
            CupertinoButton(
              child: Text("EVET"),
              onPressed: () {
                firebaseAuth.signOut();
                Navigator.of(context).popUntil((route) => route.isFirst);
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
