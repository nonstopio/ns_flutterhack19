import 'package:flutter/material.dart';
import 'package:flutterhackathon/components/app_loading_widget.dart';
import 'package:flutterhackathon/utils/utils.dart';
import 'package:flutterhackathon/components/app_error_widget.dart';

class InviteMemberScreen extends StatefulWidget {
  @override
  _InviteMemberScreenState createState() => _InviteMemberScreenState();
}

class _InviteMemberScreenState extends State<InviteMemberScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalObjectKey<ScaffoldState>('InviteMemberScreen');

  PageState _pageState = PageState.Loading;
  String message = "";

  @override
  void initState() {
    super.initState();
    appLogs("InviteMemberScreen", tag: "Screen");
    Future.delayed(Duration(milliseconds: 500), () => getInviteMemberScreenDetails());
  }

  getInviteMemberScreenDetails() async {
    hideLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Invite Member'),
      ),
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
        callback: () => getInviteMemberScreenDetails(),
      ),
    );
  }

  showLoading() {
    appLogs("InviteMemberScreen:showLoading");

    setState(() => _pageState = PageState.Loading);
  }

  hideLoading() {
    appLogs("InviteMemberScreen:hideLoading");

    setState(() => _pageState = PageState.Loaded);
  }

  showError() {
    appLogs("InviteMemberScreen:showError");

    setState(() => _pageState = PageState.Error);
  }
}
