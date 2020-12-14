import 'package:flutter/material.dart';
import 'package:hizmet_mobil_uygulama/ui/MainPage.dart';
import 'package:hizmet_mobil_uygulama/ui/SignInPage.dart';
import 'package:hizmet_mobil_uygulama/viewmodel/user_model.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserModel>(context, listen: true);  // "listen" default olarak "true " kabul edildigi icin bunu yazmaya da bilisiniz
    //Provider<UserModel>(create: (_)=> UserModel());
    if (_userModel.state == ViewState.Idle) {
      if (_userModel.user == null) {
        return Container();
      } else {
        return Container();
      }
    } else {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
