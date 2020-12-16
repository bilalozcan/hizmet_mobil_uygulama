import 'dart:io';

import 'package:image_picker/image_picker.dart';

abstract class StorageBase {
  Future<String> uploadFile(
      String userID,
      String fileType,
      File fileToUpload,
      );
}