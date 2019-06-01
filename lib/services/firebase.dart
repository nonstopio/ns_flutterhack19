import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:flutterhackathon/utils/utils.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

final FirebaseDatabase database = FirebaseDatabase.instance;

final _prefix = 'db1'; // could be used for partitioning or versioning
final _rootRef = database.reference().child(_prefix);

final userRef = _rootRef.child('user');

class ReactiveRef<DataType> {
  final DatabaseReference ref;

  ReactiveRef(this.ref);
}

Future<String> uploadPhoto(File image, {String imageType = "profile"}) async {
  String url = "";

  try {
    File compressedFile = await FlutterNativeImage.compressImage(image.path);

    String imageFileName = Uuid().v1() + extension(image.path);

    apiLogs("uploadPhoto imageFileName $imageFileName");

    StorageReference ref = FirebaseStorage.instance.ref().child(imageType).child(imageFileName);
    StorageUploadTask uploadTask = ref.putFile(compressedFile);
    url = await (await uploadTask.onComplete).ref.getDownloadURL();
  } on Exception catch (e) {
    apiLogs("uploadPhoto failed $e");

    return null;
  }

  return url;
}
