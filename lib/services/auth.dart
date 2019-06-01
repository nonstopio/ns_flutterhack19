import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterhackathon/services/firebase.dart';
import 'package:flutterhackathon/utils/utils.dart';
import 'package:flutterhackathon/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

final auth = new Auth();
Future<SharedPreferences> sharedPreferencesObject = SharedPreferences.getInstance();

FirebaseUser firebaseUser;

class Auth {
  User currentUser;
}

Future<Null> setUserFromSharedPreference() async {
  final SharedPreferences sharedPreferences = await sharedPreferencesObject;

  appLogs("setUserFromPreference");

  User user = new User(
    uid: sharedPreferences.getString(Strings.uid) ?? "",
    loggedIn: sharedPreferences.getBool(Strings.loggedIn) ?? false,
    name: sharedPreferences.getString(Strings.name) ?? "",
    email: sharedPreferences.getString(Strings.email) ?? "",
    phone: sharedPreferences.getString(Strings.phone) ?? "",
    authToken: sharedPreferences.getString(Strings.authToken) ?? "",
    fcmToken: sharedPreferences.getString(Strings.fcmToken) ?? "",
    profileImageUrl: sharedPreferences.getString(Strings.profileImageUrl) ?? "",
  );

  auth.currentUser = user;

  logUser();
}

Future<Null> updateUserInSharedPreference() async {
  appLogs("updateUserInSharedPrefs");

  final SharedPreferences sharedPreferences = await sharedPreferencesObject;

  sharedPreferences.setBool(Strings.loggedIn, auth.currentUser.loggedIn ?? false);
  sharedPreferences.setString(Strings.uid, auth.currentUser.uid);
  sharedPreferences.setString(Strings.name, auth.currentUser.name);
  sharedPreferences.setString(Strings.phone, auth.currentUser.phone);
  sharedPreferences.setString(Strings.email, auth.currentUser.email);
  sharedPreferences.setString(Strings.fcmToken, auth.currentUser.fcmToken);
  sharedPreferences.setString(Strings.authToken, auth.currentUser.authToken);
  sharedPreferences.setString(Strings.profileImageUrl, auth.currentUser.profileImageUrl);

  logUser();
}








logUser() {
  appLogs('''
  ===========Current User=========
  UID:${auth.currentUser.uid}
  Name:${auth.currentUser.name}
  Email:${auth.currentUser.email}
  profileImageUrl:${auth.currentUser.profileImageUrl}
  phone:${auth.currentUser.phone}
  authToken:${auth.currentUser.authToken}
  fcmToken:${auth.currentUser.fcmToken}
  
  ''');
}
