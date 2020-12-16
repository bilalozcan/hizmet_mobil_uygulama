import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:hizmet_mobil_uygulama/services/StorageBase.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseStorageService implements StorageBase {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  Reference _storageReference;
  @override
  Future<String> uploadFile(
      String userID, String fileType, File fileToUpload) async {
     _storageReference = _firebaseStorage
        .ref()
        .child(userID)
        .child(fileType)
        .child("profil_foto.png");
    var uploadTask = _storageReference.putFile(fileToUpload);

    //var url = await (await uploadTask.onComplete).ref.getDownloadURL();
    var url=await(await uploadTask).ref.getDownloadURL();

    return url;
  }
}