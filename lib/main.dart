import 'package:flutter/material.dart';
import 'package:flutterhackathon/Services/services.dart';
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
      home: SplashScreen(),
      theme: ThemeData(),
    );
  }
}
