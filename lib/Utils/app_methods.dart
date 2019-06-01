import 'dart:math';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutterhackathon/Theme/theme.dart';
import 'package:flutterhackathon/Utils/utils.dart';
import 'package:intl/intl.dart';

appLogs(Object object, {String tag = 'APPLOGS'}) {
  if (App.devMode) {
    String message = "$object";

    int maxLogSize = 1000;
    for (int i = 0; i <= message.length / maxLogSize; i++) {
      int start = i * maxLogSize;
      int end = (i + 1) * maxLogSize;
      end = end > message.length ? message.length : end;
      print("$tag : ${message.substring(start, end)}");
    }
  }
}

apiLogs(Object object, {String tag = 'API'}) {
  if (App.devMode) {
    String message = "$object";

    int maxLogSize = 1000;
    for (int i = 0; i <= message.length / maxLogSize; i++) {
      int start = i * maxLogSize;
      int end = (i + 1) * maxLogSize;
      end = end > message.length ? message.length : end;
      print("$tag : ${message.substring(start, end)}");
    }
  }
}

Future<bool> isConnected() async {
  var connectivityResult = await (new Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) return false;
  return true;
}

bool isFormValid(key) {
  final form = key.currentState;
  if (form.validate()) {
    form.save();
    appLogs('isFormValid:true');

    return true;
  }
  appLogs('isFormValid:false');

  return false;
}

addIfNotEmpty({String key, String value, Map parameterData}) {
  if (value.isNotEmpty) {
    parameterData.putIfAbsent(key, () => value);
  }
}

showScore({@required int marks}) async {
  if (marks == 1)
    AppToast.showSuccess(getRandomSuccessMessage());
  else
    AppToast.showError(getRandomFailMessage());
}

showLevelUp() async {
  AppToast.showSuccess(getRandomLevelUpMessage());
}

showLevelDown() async {
  AppToast.showError(getRandomLevelDownMessage());
}

String getRandomLevelUpMessage() {
  List list = [
    "Level ⬆️  😀",
    "Good, Level ⬆️ 👍",
    "Level ⬆️  👍",
  ];

  int index = new Random().nextInt(list.length);

  return list[index];
}

String getRandomLevelDownMessage() {
  List list = [
    "Level ⬇️ 👎",
    "Level ⬇️ 🙁",
    "Level ⬇️ 🙄",
  ];

  int index = new Random().nextInt(list.length);

  return list[index];
}

String getRandomSuccessMessage() {
  List list = [
    "+1 👍",
    "Good, You’re right👍",
    "You’re right 😀",
    "Awesome 👌",
  ];

  int index = new Random().nextInt(list.length);

  return list[index];
}

String getRandomFailMessage() {
  List list = [
    "+0 👎",
    "No, It’s wrong 🙁",
    "It’s wrong 🙅",
    "Incorrect ❌",
  ];

  int index = new Random().nextInt(list.length);

  return list[index];
}

showSnackBar({
  @required String title,
  @required GlobalKey<ScaffoldState> scaffoldKey,
  Color color,
  int milliseconds = 800,
  TextStyle style,
}) {
  scaffoldKey.currentState?.showSnackBar(
    new SnackBar(
      backgroundColor: color ?? Colors.red,
      duration: Duration(milliseconds: milliseconds),
      content: Container(
        constraints: BoxConstraints(minHeight: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Text(
              title,
              style: style ?? TextStyles.defaultLight,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );
}

String moneyFormat({@required double value}) {
  NumberFormat numberFormat = NumberFormat.currency(
    decimalDigits: 0,
    symbol: "₹",
  );
  return numberFormat.format(value);
}
