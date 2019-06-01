import 'package:flutter/material.dart';
import 'package:flutterhackathon/Utils/app_constants.dart';
import 'package:flutterhackathon/Utils/utils.dart';
import 'package:flutterhackathon/components/app_error_widget.dart';
import 'package:flutterhackathon/components/app_loading_widget.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalObjectKey<ScaffoldState>('SplashScreen');

  PageState _pageState = PageState.Loading;
  String message = "";

  @override
  void initState() {
    super.initState();
    appLogs("SplashScreen", tag: "Screen");
    Future.delayed(Duration(milliseconds: 500), () => getSplashScreenDetails());
  }

  getSplashScreenDetails() async {
    hideLoading();
  }

  @override
  Widget build(BuildContext context) {
    Sizes.setScreenAwareConstant(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          getBody(),
          getLoaderWidget(),
          getErrorWidget(),
        ],
      ),
    );
  }

  Widget getBody() {
    return Placeholder();
  }

  Widget getLoaderWidget() {
    return Offstage(
      offstage: _pageState != PageState.Loading,
      child: FullScreenLoader(),
    );
  }

  Widget getErrorWidget() {
    return Offstage(
      offstage: _pageState != PageState.Error,
      child: AppErrorWidget(
        message: message,
        callback: () => getSplashScreenDetails(),
      ),
    );
  }

  showLoading() {
    appLogs("SplashScreen:showLoading");

    setState(() => _pageState = PageState.Loading);
  }

  hideLoading() {
    appLogs("SplashScreen:hideLoading");

    setState(() => _pageState = PageState.Loaded);
  }

  showError() {
    appLogs("SplashScreen:showError");

    setState(() => _pageState = PageState.Error);
  }
}
