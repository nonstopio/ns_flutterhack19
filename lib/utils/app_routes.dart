import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterhackathon/Components/app_loading_widget.dart';

class AppRoutes {
  static bool loaderShowing = false;

  static void pushCupertino(BuildContext context, Widget page) {
    Navigator.of(context).push(
      new CupertinoPageRoute(builder: (context) => page),
    );
  }

  static void replaceCupertino(BuildContext context, Widget page) {
    Navigator.of(context).pushReplacement(
      new CupertinoPageRoute(builder: (context) => page),
    );
  }

  static void push(BuildContext context, Widget page) {
    Navigator.of(context).push(
      new MaterialPageRoute(builder: (context) => page),
    );
  }

  static void replace(BuildContext context, Widget page) {
    Navigator.of(context).pushReplacement(
      new MaterialPageRoute(builder: (context) => page),
    );
  }

  static void makeFirst(BuildContext context, Widget page) {
    Navigator.of(context).popUntil((predicate) => predicate.isFirst);
    Navigator.of(context).pushReplacement(
      new MaterialPageRoute(builder: (context) => page),
    );
  }

  static void pop(BuildContext context) {
    Navigator.of(context).pop();
  }

  static void dismissAlert(context) {
    Navigator.of(context).pop();
  }

  static void showLoader(context, {bool barrierDismissible = true, WillPopCallback onWillPop}) {
    loaderShowing = true;
    print('showLoader $loaderShowing');
    showDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (_) {
          return WillPopScope(
            onWillPop: onWillPop ?? () {},
            child: new FullScreenLoader(),
          );
        });
  }

  static void dismissLoader(context) {
    print('dismissLoader $loaderShowing');
    if (loaderShowing) {
      loaderShowing = false;
      Navigator.of(context).pop();
    }
  }
}
