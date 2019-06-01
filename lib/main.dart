import 'package:flutter/material.dart';
import 'package:flutterhackathon/expense/add_expense_screen.dart';
import 'package:flutterhackathon/screens/circle/my_circles_screen.dart';
import 'package:flutterhackathon/screens/feed/view_feeds_screen.dart';
import 'package:flutterhackathon/services/services.dart';
import 'package:flutterhackathon/screens/splash_screen.dart';

import 'utils/app_strings.dart';

void main() async {
  await setUserFromSharedPreference();
  await AppNotifications.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: App.appName,
      debugShowCheckedModeBanner: false,
      // home: SplashScreen(),
      home: AddExpenseScreen(),
      theme: ThemeData(
        // primarySwatch: Colors.blue,
        fontFamily: 'Rubik',
      ),
    );
  }
}
