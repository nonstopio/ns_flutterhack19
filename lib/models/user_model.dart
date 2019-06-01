import 'package:firebase_database/firebase_database.dart';
import 'package:flutterhackathon/Utils/utils.dart';
import 'package:meta/meta.dart';

class User {
  bool loggedIn;
  String uid;
  String name;
  String email;
  String phone;
  String authToken;
  String fcmToken;
  String profileImageUrl;

  User({
    @required this.loggedIn,
    @required this.uid,
    @required this.name,
    @required this.email,
    @required this.phone,
    @required this.authToken,
    @required this.fcmToken,
    @required this.profileImageUrl,
  });

  User.fromSnapshot({DataSnapshot snapshot, String tempUID}) {
    loggedIn = true;
    uid = tempUID;
    name = snapshot.value[Strings.name] as String ?? "";
    phone = snapshot.value[Strings.phone] as String ?? "";
    email = snapshot.value[Strings.email] as String ?? "";
    fcmToken = snapshot.value[Strings.fcmToken] as String ?? "";
    authToken = snapshot.value[Strings.authToken] as String ?? "";
    profileImageUrl = snapshot.value[Strings.profileImageUrl] as String ?? "";
  }

  User.fromData({
    @required String tempUID,
    @required String tempPhone,
    @required String tempAuthToken,
  }) {
    loggedIn = false;
    uid = tempUID;
    name = "";
    email = "";
    phone = tempPhone;
    authToken = "";
    fcmToken = "";
    profileImageUrl = "";
  }
}
