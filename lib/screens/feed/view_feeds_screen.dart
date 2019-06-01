import 'package:flutter/material.dart';
import 'package:flutterhackathon/components/app_loading_widget.dart';
import 'package:flutterhackathon/Utils/utils.dart';
import 'package:flutterhackathon/components/app_error_widget.dart';

class ViewFeedsScreen extends StatefulWidget {
  @override
  _ViewFeedsScreenState createState() => _ViewFeedsScreenState();
}

class _ViewFeedsScreenState extends State<ViewFeedsScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalObjectKey<ScaffoldState>('ViewFeedsScreen');

  PageState _pageState = PageState.Loaded;
  String message = "";

  @override
  void initState() {
    super.initState();
    appLogs("ViewFeedsScreen", tag: "Screen");
    Future.delayed(Duration(milliseconds: 100), () => getViewFeedsScreenDetails());
  }

  getViewFeedsScreenDetails() async {
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
        callback: () => getViewFeedsScreenDetails(),
      ),
    );
  }

  showLoading() {
    appLogs("ViewFeedsScreen:showLoading");

    setState(() => _pageState = PageState.Loading);
  }

  hideLoading() {
    appLogs("ViewFeedsScreen:hideLoading");

    setState(() => _pageState = PageState.Loaded);
  }

  showError() {
    appLogs("ViewFeedsScreen:showError");

    setState(() => _pageState = PageState.Error);
  }
}
