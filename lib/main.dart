import 'package:flutter/material.dart';
import 'package:flutterhackathon/screens/splash_screen.dart';
import 'package:flutterhackathon/services/services.dart';

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
      // home: ViewFeedsScreen(),
      theme: ThemeData(
        primaryColor: Color(0xFF00AD99),
        accentColor: Color(0xFF00AD99),
        // accentColor: Color(0xFFF24863),
        fontFamily: 'Rubik',
      ),
    );
  }
}
