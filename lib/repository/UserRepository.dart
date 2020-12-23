import 'dart:io';

import 'package:hizmet_mobil_uygulama/locator.dart';
import 'package:hizmet_mobil_uygulama/models/User_.dart';
import 'package:hizmet_mobil_uygulama/services/AuthBase.dart';
import 'package:hizmet_mobil_uygulama/services/FakeAuthService.dart';
import 'package:hizmet_mobil_uygulama/services/FirebaseAuthService.dart';
import 'package:hizmet_mobil_uygulama/services/FirebaseStorageService.dart';
import 'package:hizmet_mobil_uygulama/services/FirestoreDBService.dart';

enum AppMode { DEBUG, RELEASE }

class UserRepository implements AuthBase {
  FirebaseAuthService _firebaseAuthService = locator<FirebaseAuthService>();
  FakeAuthService _fakeAuthenticationService = locator<FakeAuthService>();
  FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();
  FirebaseStorageService _firebaseStorageService =
      locator<FirebaseStorageService>();
  AppMode appMode = AppMode.RELEASE;

  @override
  Future<User_> currentUser() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthenticationService.currentUser();
    } else {
      User_ _user = await _firebaseAuthService.currentUser();
      if (_user != null)
        return await _firestoreDBService.readUser(_user.userID);
      else
        return null;
    }
  }

  Future<User_> differentUser(String userID) async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthenticationService.currentUser();
    } else {
      return await _firestoreDBService.readUser(userID);
    }
  }

  @override
  Future<bool> signOut() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthenticationService.signOut();
    } else {
      return await _firebaseAuthService.signOut();
    }
  }

  @override
  Future<User_> signInWithGoogle() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthenticationService.signInWithGoogle();
    } else {
      User_ _user = await _firebaseAuthService.signInWithGoogle();
      if (_user != null) {
        bool _sonuc = await _firestoreDBService.saveUser(_user);
        if (_sonuc) {
          return await _firestoreDBService.readUser(_user.userID);
        } else {
          await _firebaseAuthService.signOut();
          return null;
        }
      } else
        return null;
    }
  }

  @override
  Future<User_> createUserWithEmailandPassword(String email, String password,
      String name, String surname, String username) async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthenticationService.createUserWithEmailandPassword(
          email, password, name, surname, username);
    } else {
      User_ _user = await _firebaseAuthService.createUserWithEmailandPassword(
          email, password, name, surname, username);

      bool _sonuc = await _firestoreDBService.saveUser(_user);
      if (_sonuc) {
        return await _firestoreDBService.readUser(_user.userID);
      } else
        return null;
    }
  }

  @override
  Future<User_> signInWithEmailandPassword(
      String email, String password) async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthenticationService.signInWithEmailandPassword(
          email, password);
    } else {
      User_ _user = await _firebaseAuthService.signInWithEmailandPassword(
          email, password);

      return await _firestoreDBService.readUser(_user.userID);
    }
  }

  @override
  Future<String> uploadFile(
      String userID, String fileType, File profilePhoto) async {
    if (appMode == AppMode.DEBUG) {
      return "dosya_indirme_linki";
    } else {
      String profilePhotoURL = await _firebaseStorageService.uploadFile(
          userID, fileType, profilePhoto);
      await _firestoreDBService.updateProfilePhoto(userID, profilePhotoURL);
      return profilePhotoURL;
    }
  }

  @override
  updatePassword(String newPassword) async{
    // TODO: implement updatePassword
    if(appMode==AppMode.DEBUG)
        await _fakeAuthenticationService.updatePassword(newPassword);
    else
      await _firebaseAuthService.updatePassword(newPassword);
    return true;
  }
}
