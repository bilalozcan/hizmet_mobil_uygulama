import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hizmet_mobil_uygulama/ui/resetPassword.dart';
import 'package:hizmet_mobil_uygulama/utils/DialogMessage.dart';
import 'package:hizmet_mobil_uygulama/viewmodel/comments_model.dart';
import 'package:hizmet_mobil_uygulama/viewmodel/user_model.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ayarlar"),
      ),
      body: Container(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                  final _userModel=Provider.of<UserModel>(context,listen: false);
                  final _commentsModel=Provider.of<CommentsModel>(context,listen: false);
                  _commentsModel.createComment(senderID:_userModel.user.userID,content: "Deneme yazısı",degree: 5,receiverID:_userModel.user.userID);
              },
              child: ListTile(
                leading: Icon(Icons.notifications_outlined,size: 36,color: Colors.orangeAccent,),
                title: Text("Bildirimler"),

              ),
            ),
            InkWell(
              onTap: ()  {
                Navigator.of(context).push(MaterialPageRoute(builder:(context)=>ResetPassword()));
              },
              child: ListTile(
                leading: Icon(Icons.lock,size: 36,color: Colors.black,),
                title: Text("Şifre Değiştir"),
              ),
            ),
            InkWell(
              onTap: () async {
                await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return dialogMessageForExit();
                    });
              },
              child: ListTile(
                leading: Icon(Icons.power_settings_new_outlined,color: Colors.red,size: 36,),
                title: Text("Çıkış Yap"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
