import 'package:flutter/material.dart';
import 'package:flutterhackathon/screens/circle/my_circles_screen.dart';
import 'package:flutterhackathon/screens/feed/view_feeds_screen.dart';
import 'package:flutterhackathon/screens/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NonstopIO',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: SplashScreen(),
      home: MyCirclesScreen(),
    );
  }
}
