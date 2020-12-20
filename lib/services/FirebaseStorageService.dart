import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hizmet_mobil_uygulama/services/StorageBase.dart';

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
        .child("profilePhoto.png");
    UploadTask uploadTask = _storageReference.putFile(fileToUpload);
    String url = await (await uploadTask).ref.getDownloadURL();
    return url;
  }
}
