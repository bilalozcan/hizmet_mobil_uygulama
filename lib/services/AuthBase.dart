import 'package:hizmet_mobil_uygulama/models/User_.dart';
import 'package:image_picker/image_picker.dart';

abstract class AuthBase {
  Future<User_> currentUser();
  Future<bool> signOut();
  Future<User_> signInWithGoogle();
  //Future<User> signInWithFacebook();
  Future<User_> signInWithEmailandPassword(String email, String password);
  Future<User_> createUserWithEmailandPassword(String email, String password,String name,String surname,String username);
  Future<bool> updatePassword(String newPassword);
}