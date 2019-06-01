import 'package:flutter/material.dart';
import 'package:flutterhackathon/Components/app_loading_widget.dart';
import 'package:flutterhackathon/utils/utils.dart';
import 'package:flutterhackathon/components/app_error_widget.dart';

class DemoScreen extends StatefulWidget {
  @override
  _DemoScreenState createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalObjectKey<ScaffoldState>('DemoScreen');

  PageState _pageState = PageState.Loading;
  String message = "";

  @override
  void initState() {
    super.initState();
    appLogs("DemoScreen", tag: "Screen");
    Future.delayed(Duration(milliseconds: 500), () => getDemoScreenDetails());
  }

  getDemoScreenDetails() async {
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
        callback: () => getDemoScreenDetails(),
      ),
    );
  }

  showLoading() {
    appLogs("DemoScreen:showLoading");

    setState(() => _pageState = PageState.Loading);
  }

  hideLoading() {
    appLogs("DemoScreen:hideLoading");

    setState(() => _pageState = PageState.Loaded);
  }

  showError() {
    appLogs("DemoScreen:showError");

    setState(() => _pageState = PageState.Error);
  }
}
