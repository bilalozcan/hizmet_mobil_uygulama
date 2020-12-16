import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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