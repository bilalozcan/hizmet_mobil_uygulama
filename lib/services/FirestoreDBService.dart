import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hizmet_mobil_uygulama/models/Hizmet.dart';
import 'package:hizmet_mobil_uygulama/models/User_.dart';
import 'package:hizmet_mobil_uygulama/services/DatabaseBase.dart';

class FirestoreDBService implements DatabaseBase{
  final FirebaseFirestore _firebaseDB = FirebaseFirestore.instance;
  @override
  Future<bool> saveUser(User_ user) async{
    debugPrint(user.toMap().toString());
    DocumentSnapshot _readUser =
        await _firebaseDB.doc("users/${user.userID}").get();

    if (_readUser.data() == null) {
      await _firebaseDB
          .collection("users")
          .doc(user.userID)
          .set(user.toMap());
      return true;
    } else {
      return true;
    }
  }

  @override
  Future<User_> readUser(String userID) async{
    DocumentSnapshot _readUser =
        await _firebaseDB.collection("users").doc(userID).get();
    Map<String, dynamic> _readUserInfoMap = _readUser.data();

    User_ _okunanUserNesnesi = User_.fromMap(_readUserInfoMap);
    //print("Okunan user nesnesi :" + _okunanUserNesnesi.toString());
    return _okunanUserNesnesi;
  }

  @override
  Future<bool> updateProfilePhoto(String userID, String profilePhotoUrl) async{
    await _firebaseDB
        .collection("users")
        .doc(userID)
        .update({'profileURL': profilePhotoUrl});
    return true;
  }

  @override
  Future<bool> createHizmet(Hizmet hizmet) async{
    DocumentSnapshot _readHizmet = await _firebaseDB.doc("hizmetler/${hizmet.category}/${hizmet.subCategory}/${hizmet.hizmetID}").get();
    if(_readHizmet.data() == null) {
      await _firebaseDB.collection("hizmetler").doc("${hizmet.category}/${hizmet.subCategory}/${hizmet.hizmetID}").set(hizmet.toMap());
      return true;
    } else {
      return true;
    }
  }

  @override
  Future<Hizmet> readHizmet(String hizmetID) async{
    DocumentSnapshot _readUser = await _firebaseDB.collection("hizmetler").doc(hizmetID).get();
    Map<String, dynamic> _readHizmeInfoMap = _readUser.data();
    Hizmet _okunanHizmetNesnesi = Hizmet.fromMap(_readHizmeInfoMap);
    return _okunanHizmetNesnesi;
  }




  /*@override
  Future<bool> updateProfilFoto(String userID, String profilFotoURL) {
    // TODO: implement updateProfilFoto
    throw UnimplementedError();
  }

  @override
  Future<bool> updateUserName(String userID, String yeniUserName) {
    // TODO: implement updateUserName
    throw UnimplementedError();
  }*/

}