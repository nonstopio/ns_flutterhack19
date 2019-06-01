import 'package:flutter/material.dart';
import 'package:flutterhackathon/components/app_button.dart';
import 'package:flutterhackathon/components/app_loading_widget.dart';
import 'package:flutterhackathon/theme/app_decorations.dart';
import 'package:flutterhackathon/utils/utils.dart';
import 'package:flutterhackathon/components/app_error_widget.dart';

class InviteMemberScreen extends StatefulWidget {
  @override
  _InviteMemberScreenState createState() => _InviteMemberScreenState();
}

class _InviteMemberScreenState extends State<InviteMemberScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey =
      new GlobalObjectKey<ScaffoldState>('InviteMemberScreen');

  PageState _pageState = PageState.Loading;
  String message = "";

  @override
  void initState() {
    super.initState();
    appLogs("InviteMemberScreen", tag: "Screen");
    Future.delayed(
        Duration(milliseconds: 500), () => getInviteMemberScreenDetails());
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: AppDecorations.input(
              label: 'Member Mobile Number',
              hintText: 'Enter the member mobile number',
              error: null,
            ),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            autofocus: true,
          ),
        ),
        AppButton(
          onTap: () {},
          title: 'Invite',
        )
      ],
    );
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
