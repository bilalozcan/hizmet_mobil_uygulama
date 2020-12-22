import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hizmet_mobil_uygulama/ui/LoginPage.dart';
import 'package:hizmet_mobil_uygulama/viewmodel/user_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class dialogMessageForExit extends StatefulWidget {
  @override
  _dialogMessageForExitState createState() => _dialogMessageForExitState();
}

class _dialogMessageForExitState extends State<dialogMessageForExit> {
  @override
  Widget build(BuildContext context) {
    var _userModel = Provider.of<UserModel>(context);
    return AlertDialog(
      title: Text("Hesaptan Çıkış Yapmak İstediğinize Emin Misiniz?"),
      actions: [
        CupertinoButton(
          child: Text("EVET"),
          onPressed: () async{
            await _userModel.signOut();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                      (Route<dynamic> route) => false);
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
  }
}

/*dialogMessageForExit(BuildContext context) {
  var _userModel = Provider.of<UserModel>(context);

  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Hesaptan Çıkış Yapmak İstediğinize Emin Misiniz?"),
          actions: [
            CupertinoButton(
              child: Text("EVET"),
              onPressed: () {
                _userModel.signOut();
                debugPrint("null deger " + _userModel.user.toString());
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (Route<dynamic> route) => false);
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
}*/
