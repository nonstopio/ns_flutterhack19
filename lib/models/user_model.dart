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
}
