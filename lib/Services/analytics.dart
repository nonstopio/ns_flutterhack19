import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:meta/meta.dart';
import 'package:package_info/package_info.dart';
import 'package:flutterhackathon/Services/auth.dart';
import 'package:flutterhackathon/Utils/utils.dart';

class AppAnalytics implements FirebaseAnalytics {
  final FirebaseAnalytics _firebaseAnalytics;

  AppAnalytics() : _firebaseAnalytics = new FirebaseAnalytics();

  Future<Null> log({@required String eventName, String category, Map<String, dynamic> parameters}) async {
    if (parameters == null) {
      parameters = <String, dynamic>{};
    }
    if (category == null) {
      category = "";
    }
    await logEvent(name: eventName, category: category, parameters: parameters);
  }

  @override
  Future<Null> logAppOpen() async {
    await _firebaseAnalytics.logAppOpen();
  }

  @override
  Future<Null> logEvent({
    String name,
    String category,
    Map<String, dynamic> parameters,
  }) async {
    name = name?.replaceAll(new RegExp(r' '), '-');
    category = category?.replaceAll(new RegExp(r' '), '-');
    final eventName = category == null ? name : "${name}_$category";

    // TODO: needs to get this from the config or app version or A/B testing version
    if (parameters == null) {
      parameters = <String, dynamic>{};
    }

    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String buildStr = packageInfo.buildNumber;
    String versionStr = packageInfo.version;
    parameters.putIfAbsent("version", () => versionStr + "-" + buildStr);

    if (!parameters.containsKey("phone")) {
      if (auth.currentUser != null && auth.currentUser.phone != null) {
        parameters.putIfAbsent("uid", () => auth.currentUser.uid);
        parameters.putIfAbsent("phone", () => auth.currentUser.phone);
      }
    }

    Map<String, dynamic> newParameters = new Map<String, dynamic>();
    parameters.forEach((key, dynamic value) {
      if (value != null) {
        newParameters.putIfAbsent(key, () => value);
      }
    });
    appLogs("eventName:$eventName", tag: "Analytics");

    // TODO: need to avoid parameters contains List value. This causes exception
    await _firebaseAnalytics.logEvent(name: eventName, parameters: newParameters);
  }

  @override
  Future<Null> logJoinGroup({String groupId}) async {
    await _firebaseAnalytics.logJoinGroup(groupId: groupId);
  }

  @override
  Future<Null> logLogin({String loginMethod}) async {
    await _firebaseAnalytics.logLogin(loginMethod: loginMethod);
  }

  @override
  Future<Null> logSignUp({String signUpMethod}) async {
    await _firebaseAnalytics.logSignUp(signUpMethod: signUpMethod);
  }

  @override
  Future<Null> logTutorialBegin() async {
    await _firebaseAnalytics.logTutorialBegin();
  }

  @override
  Future<Null> logTutorialComplete() async {
    await _firebaseAnalytics.logTutorialComplete();
  }

  @override
  Future<Null> setCurrentScreen({
    @required String screenName,
    String screenClassOverride: 'Flutter',
  }) async {
    await _firebaseAnalytics.setCurrentScreen(
      screenName: screenName,
      screenClassOverride: screenClassOverride,
    );
  }

  @override
  Future<Null> setUserId(String id) async {
    await _firebaseAnalytics.setUserId(id);
  }

  @override
  Future<Null> setUserProperty({String name, String value}) async {
    await _firebaseAnalytics.setUserProperty(name: name, value: value);
  }

  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
