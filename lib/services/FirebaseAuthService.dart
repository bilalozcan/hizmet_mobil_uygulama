import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hizmet_mobil_uygulama/models/User_.dart';
import 'package:hizmet_mobil_uygulama/services/AuthBase.dart';

class FirebaseAuthService implements AuthBase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<User_> currentUser() async {
    try {
      User user = await _firebaseAuth.currentUser;
      return _userFromFirebase(user);
    } catch (e) {
      print("ERROR CURRENT USER" + e.toString());
      return null;
    }
  }

  User_ _userFromFirebase(User user) {
    if (user == null) {
      return null;
    } else {
      return User_(
        userID: user.uid,
        email: user.email,
      );
    }
  }

  User_ _userFromFirebaseInfo(
      User user, String name, String surname, String username) {
    if (user == null)
      return null;
    else {
      return User_.Info(
          userID: user.uid,
          email: user.email,
          username: username,
          name: name,
          surname: surname);
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      //final _facebookLogin = FacebookLogin();
      //await _facebookLogin.logOut();

      final _googleSignIn = GoogleSignIn();
      await _googleSignIn.signOut();

      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      print("Sign Out Error:" + e.toString());
      return false;
    }
  }

  @override
  Future<User_> signInWithGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    GoogleSignInAccount _googleUser = await _googleSignIn.signIn();

    if (_googleUser != null) {
      GoogleSignInAuthentication _googleAuth = await _googleUser.authentication;
      if (_googleAuth.idToken != null && _googleAuth.accessToken != null) {
        UserCredential result = await _firebaseAuth.signInWithCredential(
            GoogleAuthProvider.credential(
                idToken: _googleAuth.idToken,
                accessToken: _googleAuth.accessToken));
        User _user = result.user;
        return _userFromFirebase(_user);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<User_> createUserWithEmailandPassword(String email, String password,
      String name, String surname, String username) async {
    UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
   // return _userFromFirebase(result.user);
    return _userFromFirebaseInfo(result.user, name, surname, username);
  }

  @override
  Future<User_> signInWithEmailandPassword(
      String email, String password) async {
    UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(result.user);
  }
}
