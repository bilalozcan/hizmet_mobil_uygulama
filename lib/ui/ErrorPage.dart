import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.0),
            child: Center(
                child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline_rounded,
                    color: Colors.red,
                    size: 96,
                  ),
                SizedBox(height: 5,),
                Text("Bir şeyler yanlış gitti. Lütfen tekrar deneyiniz",style:GoogleFonts.shadowsIntoLight(fontSize: 36),),CupertinoButton(child: Text("Geri Dön"),onPressed: (){
                  Navigator.of(context).pop();
                  },)],
              ),
            ))),
      ),
    );
  }
}
