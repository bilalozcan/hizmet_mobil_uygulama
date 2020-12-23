import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hizmet_mobil_uygulama/models/Category.dart';
import 'package:hizmet_mobil_uygulama/models/Hizmet.dart';
import 'package:hizmet_mobil_uygulama/models/User_.dart';
import 'package:hizmet_mobil_uygulama/services/DatabaseBase.dart';

class FirestoreDBService implements DatabaseBase {
  final FirebaseFirestore _firebaseDB = FirebaseFirestore.instance;

  @override
  Future<bool> saveUser(User_ user) async {
    debugPrint(user.toMap().toString());
    DocumentSnapshot _readUser =
        await _firebaseDB.doc("users/${user.userID}").get();

    if (_readUser.data() == null) {
      await _firebaseDB.collection("users").doc(user.userID).set(user.toMap());
      return true;
    } else {
      return true;
    }
  }

  @override
  Future<User_> readUser(String userID) async {
    DocumentSnapshot _readUser =
        await _firebaseDB.collection("users").doc(userID).get();
    Map<String, dynamic> _readUserInfoMap = _readUser.data();
    if (_readUserInfoMap != null) {
      User_ _okunanUserNesnesi = User_.fromMap(_readUserInfoMap);
      //print("Okunan user nesnesi :" + _okunanUserNesnesi.toString());
      return _okunanUserNesnesi;
    } else
      return null;
  }

  @override
  Future<bool> updateProfilePhoto(String userID, String profilePhotoUrl) async {
    await _firebaseDB
        .collection("users")
        .doc(userID)
        .update({'profileURL': profilePhotoUrl});
    return true;
  }

  @override
  Future<bool> createHizmet(Hizmet hizmet) async {
    var documentReference = _firebaseDB
        .collection("hizmetler")
        .doc("${hizmet.category}")
        .collection("${hizmet.subCategory}")
        .doc("${hizmet.hizmet}")
        .collection("${hizmet.hizmet}")
        .doc();
    DocumentSnapshot documentSnapshot = await documentReference.get();
    if (documentSnapshot.data() == null) {
      await documentReference.set(hizmet.toMap());
      return true;
    } else
      return true;
  }

  @override
  Future<Hizmet> readHizmet(
      String category, String subCategory, String hizmet) async {
    DocumentSnapshot _readUser = await _firebaseDB
        .collection("hizmetler")
        .doc("$category")
        .collection("${subCategory}")
        .doc("${hizmet}")
        .collection("${hizmet}")
        .doc()
        .get();
    Map<String, dynamic> _readHizmeInfoMap = _readUser.data();
    Hizmet _okunanHizmetNesnesi = Hizmet.fromMap(_readHizmeInfoMap);
    return _okunanHizmetNesnesi;
  }

  @override
  Future<List<Hizmet>> readFilterHizmet(
      {String category, String subCategory, String hizmet,List<String> categories,List<List<String>> subCategories}) async {
    List<Hizmet> hizmetler = [];
    QuerySnapshot querySnapshot;
    Hizmet _tempHizmet;
    if(hizmet!=null && (category!=null && subCategory!=null)) {
        debugPrint("ilk if calisti");
         querySnapshot = await _firebaseDB
            .collection('hizmetler')
            .doc(category)
            .collection(subCategory)
            .doc(hizmet)
            .collection(hizmet)
            .get();
        for (DocumentSnapshot hizmet in querySnapshot.docs) {
          _tempHizmet = Hizmet.fromMap(hizmet.data());
          hizmetler.add(_tempHizmet);
        }
    }
      else if(hizmet==null && (category!=null && subCategory!=null))
        {
          debugPrint("ikinci if calisti");
          if(categories!=null) {
            for (int i = 0; i < categories.length; ++i) {
               querySnapshot = await _firebaseDB.collection("hizmetler").doc(
                  category).collection(subCategory)
                  .doc(categories[i])
                  .collection(categories[i])
                  .get();
              for (DocumentSnapshot hizmet in querySnapshot.docs) {
                _tempHizmet = Hizmet.fromMap(hizmet.data());
                hizmetler.add(_tempHizmet);
              }
            }
          }
        }
      else if(hizmet==null && (category!=null && subCategory==null))
        {
          DocumentReference _documentReference=await _firebaseDB.collection("hizmetler").doc(category);
          CollectionReference _collectionReference;
          if(categories!=null && subCategories!=null) {
            for(int i=0;i<categories.length;++i)
              {
                _collectionReference=_documentReference.collection(categories[i]);
                for(int j=0;j<subCategories[i].length;++j)
                  {
                    querySnapshot=await _collectionReference.doc(subCategories[i][j]).collection(subCategories[i][j]).get();
                    for (DocumentSnapshot hizmet in querySnapshot.docs) {
                      _tempHizmet = Hizmet.fromMap(hizmet.data());
                      hizmetler.add(_tempHizmet);
                    }
                  }
              }
          }
        }
    return hizmetler;
  }

/*

  @override
  Future<bool> updateUserName(String userID, String yeniUserName) {
    // TODO: implement updateUserName
    throw UnimplementedError();
  }*/

}
