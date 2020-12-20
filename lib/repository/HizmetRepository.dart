import 'package:flutter/material.dart';
import 'package:hizmet_mobil_uygulama/locator.dart';
import 'package:hizmet_mobil_uygulama/models/Hizmet.dart';
import 'package:hizmet_mobil_uygulama/services/FirebaseStorageService.dart';
import 'package:hizmet_mobil_uygulama/services/FirestoreDBService.dart';
import 'package:hizmet_mobil_uygulama/services/HizmetBase.dart';

enum AppMode { DEBUG, RELEASE }

class HizmetRepository implements HizmetBase {
  FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();
  FirebaseStorageService _firebaseStorageService =
      locator<FirebaseStorageService>();
  AppMode appMode = AppMode.RELEASE;

  @override
  Future<Hizmet> createHizmet(
      {
      title,
      category,
      subCategory,
      publisher,
      detail,
      address,
      payment}) async {
    if (appMode == AppMode.DEBUG) {
      return Hizmet.Info( title, category, subCategory, publisher,
          detail, address, payment);
    }else {
      Hizmet _hizmet = Hizmet.Info( title, category, subCategory, publisher,
          detail, address, payment);
      bool result = await _firestoreDBService.createHizmet(_hizmet);
      if(result){
        return await _firestoreDBService.readHizmet( _hizmet.category, _hizmet.subCategory);
      }else {
        return null;
      }
    }
  }

  @override
  Future<List<Hizmet>> readFilterHizmet({String category, String subCategory}) async{
    if (appMode == AppMode.DEBUG) {
      return null;
    }else {
      var hizmetList = await _firestoreDBService.readFilterHizmet(category: category, subCategory: subCategory);
      debugPrint("hizmetList"+hizmetList.toString());
      return hizmetList;
    }
  }

  @override
  Future<Hizmet> readHizmet(String category, String subCategory) {
    // TODO: implement readHizmet
    throw UnimplementedError();
  }

  @override
  Future<Hizmet> setHizmet(Hizmet hizmet) {
    // TODO: implement setHizmet
    throw UnimplementedError();
  }

}
