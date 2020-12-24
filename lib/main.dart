import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hizmet_mobil_uygulama/locator.dart';
import 'package:hizmet_mobil_uygulama/ui/LoadingPage.dart';
import 'package:hizmet_mobil_uygulama/viewmodel/comments_model.dart';
import 'package:hizmet_mobil_uygulama/viewmodel/hizmet_model.dart';
import 'package:hizmet_mobil_uygulama/viewmodel/user_model.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  runApp(HizmetApp());
}

class HizmetApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserModel()),
        ChangeNotifierProvider(create: (context) => HizmetModel()),
        ChangeNotifierProvider(create: (context)=>CommentsModel()),
      ],
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
            inputDecorationTheme: InputDecorationTheme(
              helperStyle: TextStyle(color: Colors.red),
              labelStyle: TextStyle(color: Colors.red),
              focusColor: Colors.black,
            ),
            bottomSheetTheme: BottomSheetThemeData(
              backgroundColor: Colors.white.withOpacity(0.8),
            ),
          ),
          home: LoadingPage()),
    );
  }
}
