import 'package:flutter/material.dart';
import 'package:hizmet_mobil_uygulama/ui/HomePage.dart';
import 'package:hizmet_mobil_uygulama/ui/MainPage.dart';
import 'package:hizmet_mobil_uygulama/viewmodel/user_model.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserModel>(context, listen: true);
    if (_userModel.state == ViewState.Idle) {
      if (_userModel.user == null) {
        return SignInPage();
      } else {
        return MainPage();
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
