import 'package:flutter/material.dart';
import 'package:flutterhackathon/components/app_loading_widget.dart';
import 'package:flutterhackathon/utils/utils.dart';
import 'package:flutterhackathon/components/app_error_widget.dart';

class AddCircleScreen extends StatefulWidget {
  @override
  _AddCircleScreenState createState() => _AddCircleScreenState();
}

class _AddCircleScreenState extends State<AddCircleScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalObjectKey<ScaffoldState>('AddCircleScreen');

  PageState _pageState = PageState.Loading;
  String message = "";

  @override
  void initState() {
    super.initState();
    appLogs("AddCircleScreen", tag: "Screen");
    Future.delayed(Duration(milliseconds: 500), () => getAddCircleScreenDetails());
  }

  getAddCircleScreenDetails() async {
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
    return ListView();
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
        callback: () => getAddCircleScreenDetails(),
      ),
    );
  }

  showLoading() {
    appLogs("AddCircleScreen:showLoading");

    setState(() => _pageState = PageState.Loading);
  }

  hideLoading() {
    appLogs("AddCircleScreen:hideLoading");

    setState(() => _pageState = PageState.Loaded);
  }

  showError() {
    appLogs("AddCircleScreen:showError");

    setState(() => _pageState = PageState.Error);
  }
}
