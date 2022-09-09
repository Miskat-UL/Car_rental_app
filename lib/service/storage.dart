import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
// import 'package:uuid/uuid.dart';

class Storage {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImage(
      String childName, Uint8List file, bool isPost) async {
    Reference ref = _storage.ref().child(childName);

    // if (isPost) {
    //   String id = const Uuid().v1();
    //   ref
    // }
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}


