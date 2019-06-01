import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutterhackathon/services/auth.dart';
import 'package:flutterhackathon/theme/theme.dart';
import 'package:flutterhackathon/Utils/app_size.dart';
import 'package:flutterhackathon/Utils/utils.dart';
import 'package:flutterhackathon/screens/home/home_screen.dart';
import 'package:flutterhackathon/screens/others/no_internet.dart';
import 'package:flutterhackathon/screens/tutorial/tutorial_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future checkInternetRedirectUser() async {
    appLogs("checkInternet");
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      AppRoutes.makeFirst(context, NoInternetScreen());
    } else {
      if (auth.currentUser.loggedIn) {
        AppRoutes.makeFirst(context, HomeScreen());
      } else {
        AppRoutes.makeFirst(context, TutorialScreen());
      }
    }
  }

  @override
  void initState() {
    super.initState();
    appLogs("SplashScreen", tag: "Screen");

    Future.delayed(Duration(milliseconds: 500), () => checkInternetRedirectUser());
  }

  @override
  Widget build(BuildContext context) {
    Sizes.setScreenAwareConstant(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            Center(
              child: Container(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      Assets.wordsmayaLogo,
                      fit: BoxFit.fitWidth,
                      width: screenWidth - Sizes.s100,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 50.0,
              child: Container(
                width: screenWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'App Version',
                      style: TextStyles.versionName.copyWith(color: AppColors.primary),
                    ),
                    Text(
                      App.versionName,
                      style: TextStyles.versionName.copyWith(color: AppColors.primary),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 16.0),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
