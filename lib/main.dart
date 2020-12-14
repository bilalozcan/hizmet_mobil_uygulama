import 'package:flutter/material.dart';
import 'package:hizmet_mobil_uygulama/locator.dart';
import 'package:hizmet_mobil_uygulama/ui/LoadingPage.dart';
import 'package:hizmet_mobil_uygulama/viewmodel/user_model.dart';
import 'package:provider/provider.dart';

void main() {
  setupLocator();
  runApp(HizmetApp());
}

class HizmetApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserModel(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.white,
            accentColor: Colors.white,
            canvasColor: Colors.white,
            appBarTheme: AppBarTheme(
                actionsIconTheme: IconThemeData(
              color: Color.fromRGBO(34, 63, 71, 1),
            )),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: Colors.white,
              selectedItemColor: Color.fromRGBO(30, 146, 179, 1),
              unselectedItemColor: Color.fromRGBO(34, 63, 71, 1),
            ),
          ),
          home: LoadingPage()),
    );
  }
}
