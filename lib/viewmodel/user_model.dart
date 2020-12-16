import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hizmet_mobil_uygulama/locator.dart';
import 'package:hizmet_mobil_uygulama/models/User_.dart';
import 'package:hizmet_mobil_uygulama/repository/UserRepository.dart';
import 'package:hizmet_mobil_uygulama/services/AuthBase.dart';
import 'package:image_picker_platform_interface/src/types/picked_file/unsupported.dart';

enum ViewState { Idle, Busy }//busy meşgul / ıdle bos

class UserModel with ChangeNotifier implements AuthBase {
  ViewState _state = ViewState.Idle;
  UserRepository _userRepository = locator<UserRepository>();
  User_ _user;

  User_ get user => _user;

  ViewState get state => _state;

  get sifreHataMesaji => null;

  get emailHataMesaji => null;

  set state(ViewState value) {
    _state = value;
    notifyListeners();
  }

  UserModel() {
    currentUser();
  }

  @override
  Future<User_> currentUser() async {
    try {
      state = ViewState.Busy;
      _user = await _userRepository.currentUser();
      if (_user != null)
        return _user;
      else
        return null;
    } catch (e) {
      debugPrint("Viewmodeldeki current user hata:" + e.toString());
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      state = ViewState.Busy;
      bool sonuc = await _userRepository.signOut();
      _user = null;
      return sonuc;
    } catch (e) {
      debugPrint("Viewmodeldeki current user hata:" + e.toString());
      return false;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<User_> signInWithGoogle() async {
    try {
      state = ViewState.Busy;
      _user = await _userRepository.signInWithGoogle();
      if (_user != null)
        return _user;
      else
        return null;
    } catch (e) {
      debugPrint("Viewmodeldeki current user hata:" + e.toString());
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<User_> createUserWithEmailandPassword(
      String email, String password,String name,String surname,String username) async {
    try {
      state = ViewState.Busy;
      _user =
          await _userRepository.createUserWithEmailandPassword(email, password,name,surname,username);
      return _user;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<User_> signInWithEmailandPassword(
      String email, String password) async {
    try {
      state = ViewState.Busy;
      _user = await _userRepository.signInWithEmailandPassword(email, password);
      return _user;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<String> uploadFile(String userID, String fileType, File profilePhoto) async{
    try{
      state = ViewState.Busy;
      var downloadLink =
      await _userRepository.uploadFile(userID, fileType, profilePhoto);
      return downloadLink;
    }finally{
      state = ViewState.Idle;
    }

  }
}
