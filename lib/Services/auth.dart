import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterhackathon/Utils/utils.dart';
import 'package:flutterhackathon/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'services.dart';

final auth = new Auth();
Future<SharedPreferences> sharedPreferencesObject = SharedPreferences.getInstance();
final analytics = new AppAnalytics();

FirebaseUser firebaseUser;

class Auth {
  User currentUser;
}

Future<Null> setUserFromSharedPreference() async {
  final SharedPreferences sharedPreferences = await sharedPreferencesObject;

  appLogs("setUserFromPreference");

  User user = new User(
    uid: "J6sa19UE0JSPf7qZABuq3jdfmdX2",
    loggedIn: sharedPreferences.getBool(Strings.loggedIn) ?? false,
    notificationOn: sharedPreferences.getBool(Strings.notificationOn) ?? true,
    firstName: sharedPreferences.getString(Strings.firstName) ?? "",
    lastName: sharedPreferences.getString(Strings.lastName) ?? "",
    email: sharedPreferences.getString(Strings.email) ?? "",
    phone: sharedPreferences.getString(Strings.phone) ?? "",
    authToken: sharedPreferences.getString(Strings.authToken) ?? "",
    fcmToken: sharedPreferences.getString(Strings.fcmToken) ?? "",
    jwtToken: sharedPreferences.getString(Strings.jwtToken) ?? "",
    profileImageUrl: sharedPreferences.getString(Strings.profileImageUrl) ?? "",
  );

  auth.currentUser = user;

  await setAnalyticsUserData();

  logUser();
}

Future<Null> updateUserInSharedPreference() async {
  appLogs("updateUserInSharedPrefs");

  final SharedPreferences sharedPreferences = await sharedPreferencesObject;

  sharedPreferences.setBool(Strings.loggedIn, auth.currentUser.loggedIn ?? false);
  sharedPreferences.setBool(Strings.notificationOn, auth.currentUser.notificationOn ?? true);
  sharedPreferences.setString(Strings.uid, auth.currentUser.uid);
  sharedPreferences.setString(Strings.firstName, auth.currentUser.firstName);
  sharedPreferences.setString(Strings.lastName, auth.currentUser.lastName);
  sharedPreferences.setString(Strings.phone, auth.currentUser.phone);
  sharedPreferences.setString(Strings.email, auth.currentUser.email);
  sharedPreferences.setString(Strings.fcmToken, auth.currentUser.fcmToken);
  sharedPreferences.setString(Strings.authToken, auth.currentUser.authToken);
  sharedPreferences.setString(Strings.jwtToken, auth.currentUser.jwtToken);
  sharedPreferences.setString(Strings.profileImageUrl, auth.currentUser.profileImageUrl);

  await setAnalyticsUserData();

  logUser();
}

setAnalyticsUserData() async {
  if (auth.currentUser.uid.isEmpty) return;

  /* --------AppAnalytics-----------   */
  analytics.setUserId(auth.currentUser.uid);
  analytics.setUserProperty(name: Strings.phone, value: auth.currentUser.phone);
  analytics.setUserProperty(name: Strings.email, value: auth.currentUser.email);
  analytics.setUserProperty(name: Strings.firstName, value: auth.currentUser.firstName);
  /* --------AppAnalytics-----------   */
}

logUser() {
  appLogs('''
  ===========Current User=========
  UID:${auth.currentUser.uid}
  Name:${auth.currentUser.firstName}
  lastName:${auth.currentUser.lastName}
  Email:${auth.currentUser.email}
  profileImageUrl:${auth.currentUser.profileImageUrl}
  phone:${auth.currentUser.phone}
  authToken:${auth.currentUser.authToken}
  jwtToken:${auth.currentUser.jwtToken}
  fcmToken:${auth.currentUser.fcmToken}
  
  ''');
}
