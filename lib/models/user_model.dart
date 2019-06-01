import 'package:meta/meta.dart';

class User {
  bool loggedIn;
  bool notificationOn;
  String uid;
  String firstName;
  String lastName;
  String email;
  String phone;
  String authToken;
  String fcmToken;
  String profileImageUrl;
  String jwtToken;

  User({
    @required this.loggedIn,
    @required this.notificationOn,
    @required this.uid,
    @required this.firstName,
    @required this.lastName,
    @required this.email,
    @required this.phone,
    @required this.authToken,
    @required this.fcmToken,
    @required this.jwtToken,
    @required this.profileImageUrl,
  });
}
