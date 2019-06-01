import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutterhackathon/Services/auth.dart';
import 'package:flutterhackathon/utils/app_methods.dart';
import 'package:flutterhackathon/utils/utils.dart';

final notifications = new FirebaseMessaging();

class AppNotifications {
  static String fcmToken = '';

  static Future<Null> init() async {
    appLogs("AppNotifications init");

    notifications.requestNotificationPermissions(const IosNotificationSettings(sound: true, badge: true, alert: true));

    fcmToken = await notifications.getToken();
    appLogs("FCM TOKEN : $fcmToken");

    notifications.onTokenRefresh.listen((newToken) {
      fcmToken = newToken;
      appLogs("FCM TOKEN onTokenRefresh: $fcmToken");
    });

    await updateFCMToken();
  }

  static Future<Null> config() async {
    appLogs("AppNotifications Configure");
    notifications.configure(onMessage: (msg) async {
      appLogs('FCM onMessage: ' + msg.toString());
    }, onLaunch: (lun) async {
      appLogs('FCM onLaunch: ' + lun.toString());
    }, onResume: (res) async {
      appLogs('FCM onResume: ' + res.toString());
    });
  }

  static Future<Null> updateFCMToken() async {
    auth.currentUser.fcmToken = fcmToken;
    await updateUserInSharedPreference();
  }
}
