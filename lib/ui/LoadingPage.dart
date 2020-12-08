import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hizmet_mobil_uygulama/main.dart';
import 'package:hizmet_mobil_uygulama/ui/MainPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  int _isActive = null;

  active() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (firebaseAuth.currentUser != null) {
      _isActive = sharedPreferences.getInt("login");
      debugPrint("active() isActiveee" + _isActive.toString());
    } else{
      Navigator.pushReplacementNamed(context, "/SignIn");
    }
    if(_isActive != null){
      if(_isActive == 1)
        Navigator.pushReplacementNamed(context, "/MainPage");
      else if(_isActive == 0)
        Navigator.pushReplacementNamed(context, "/SignIn");
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    active();
  }
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(),
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Hizmet App",
                style: GoogleFonts.balooTamma(fontSize: 48),
              ),
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
