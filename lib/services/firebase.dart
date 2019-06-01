import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:flutterhackathon/services/services.dart';
import 'package:flutterhackathon/utils/utils.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

final FirebaseDatabase database = FirebaseDatabase.instance;

final _prefix = 'db1'; // could be used for partitioning or versioning
final _rootRef = database.reference().child(_prefix);

final userRef = _rootRef.child('user');
final circleRef = _rootRef.child('circle');
final circleFeedRef = _rootRef.child('circle_feed');
final expenseRef = _rootRef.child('expense');
final userCircleRef = _rootRef.child('user_circle');

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

Future<Null> updateUser() async {
  await userRef.child(auth.currentUser.uid).update({
    Strings.name: auth.currentUser.name,
    Strings.phone: auth.currentUser.phone,
    Strings.email: auth.currentUser.email,
    Strings.fcmToken: auth.currentUser.fcmToken,
    Strings.authToken: auth.currentUser.authToken,
    Strings.profileImageUrl: auth.currentUser.profileImageUrl,
  });
}

Future<Null> createDefaultCircle() async {
  DatabaseReference defaultCircle = circleRef.push();

  String circleId = defaultCircle.key;

  await defaultCircle.set({
    Strings.name: "My Circle",
    Strings.description: "My first circle",
    Strings.createdBy: auth.currentUser.uid,
    Strings.authToken: auth.currentUser.authToken,
    Strings.totalFunds: "00.00",
  });

  await defaultCircle.set({
    Strings.name: "My Circle",
    Strings.description: "My first circle",
    Strings.createdBy: auth.currentUser.uid,
    Strings.totalFunds: "00.00",
  });

  await userCircleRef.child(auth.currentUser.uid).child(circleId).set({
    Strings.name: "My Circle",
  });
}

ReactiveRef<Map> getMyCircles() {
  return new ReactiveRef(userCircleRef.child(auth.currentUser.uid));
}

Query getCircleFeed(String circleId) {
  return circleFeedRef.child(circleId);
}
