import 'package:flutter/material.dart';
/* Kullanıcı üye olduğunda ona e mailin gittiğini bildirme, özel ders ilanının paylaşıldığını bildirmek icin
uygulamanın alt tarafında çıkan Toast Message lar.
 */

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