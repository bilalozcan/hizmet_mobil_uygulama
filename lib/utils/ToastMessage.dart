import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
/* Kullanıcı üye olduğunda ona e mailin gittiğini bildirme, özel ders ilanının paylaşıldığını bildirmek icin
uygulamanın alt tarafında çıkan Toast Message lar.
 */

toastMessage(String message)async
{
 return await Fluttertoast.showToast(msg: message,toastLength: Toast.LENGTH_LONG,backgroundColor: Colors.red,textColor: Colors.white,fontSize: 16);
}

void showToast(BuildContext context,String message,Color color) {
 final scaffoldMessenger = ScaffoldMessenger.of(context);
 scaffoldMessenger.showSnackBar(
  SnackBar(
   content: Text(message,style: TextStyle(color:color),),
   action: SnackBarAction(
       label: 'TAMAM', onPressed: scaffoldMessenger.hideCurrentSnackBar),
  ),
 );
}