import 'package:flutter/material.dart';
import 'package:flutterhackathon/components/app_loading_widget.dart';
import 'package:flutterhackathon/Utils/utils.dart';
import 'package:flutterhackathon/components/app_error_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalObjectKey<ScaffoldState>('HomeScreen');

  PageState _pageState = PageState.Loading;
  String message = "";

  @override
  void initState() {
    super.initState();
    appLogs("HomeScreen", tag: "Screen");
    Future.delayed(Duration(milliseconds: 500), () => getHomeScreenDetails());
  }

  getHomeScreenDetails() async {
    hideLoading();
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
        callback: () => getHomeScreenDetails(),
      ),
    );
  }

  showLoading() {
    appLogs("HomeScreen:showLoading");

    setState(() => _pageState = PageState.Loading);
  }

  hideLoading() {
    appLogs("HomeScreen:hideLoading");

    setState(() => _pageState = PageState.Loaded);
  }

  showError() {
    appLogs("HomeScreen:showError");

    setState(() => _pageState = PageState.Error);
  }
}
