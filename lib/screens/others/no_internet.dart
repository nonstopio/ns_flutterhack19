import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutterhackathon/Components/app_loading_widget.dart';
import 'package:flutterhackathon/Services/services.dart';
import 'package:flutterhackathon/utils/utils.dart';
import 'package:flutterhackathon/components/app_error_widget.dart';
import 'package:flutterhackathon/screens/splash_screen.dart';

class NoInternetScreen extends StatefulWidget {
  @override
  _NoInternetScreenState createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalObjectKey<ScaffoldState>('NoInternetScreen');

  PageState _pageState = PageState.Loading;

  String message = Strings.noInternetMessage;

  @override
  void initState() {
    super.initState();
    appLogs("NoInternetScreen", tag: "Screen");
    Future.delayed(Duration(milliseconds: 500), () => getNoInternetScreenDetails());
  }

  getNoInternetScreenDetails() async {
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      AppRoutes.makeFirst(context, NoInternetScreen());
    } else {
      if (auth.currentUser.loggedIn) {
        AppRoutes.makeFirst(context, SplashScreen());
      } else {
        showError();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
        callback: () => getNoInternetScreenDetails(),
      ),
    );
  }

  showLoading() {
    appLogs("NoInternetScreen:showLoading");

    setState(() => _pageState = PageState.Loading);
  }

  hideLoading() {
    appLogs("NoInternetScreen:hideLoading");

    setState(() => _pageState = PageState.Loaded);
  }

  showError() {
    appLogs("NoInternetScreen:showError");

    setState(() => _pageState = PageState.Error);
  }
}
