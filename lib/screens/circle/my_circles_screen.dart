import 'package:flutter/material.dart';
import 'package:flutterhackathon/components/app_loading_widget.dart';
import 'package:flutterhackathon/Utils/utils.dart';
import 'package:flutterhackathon/components/app_error_widget.dart';
import 'package:flutterhackathon/components/circle_card.dart';

class MyCirclesScreen extends StatefulWidget {
  @override
  _MyCirclesScreenState createState() => _MyCirclesScreenState();
}

class _MyCirclesScreenState extends State<MyCirclesScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalObjectKey<ScaffoldState>('MyCirclesScreen');

  PageState _pageState = PageState.Loading;
  String message = "";

  @override
  void initState() {
    super.initState();
    appLogs("MyCirclesScreen", tag: "Screen");
    Future.delayed(Duration(milliseconds: 500), () => getMyCirclesScreenDetails());
  }

  getMyCirclesScreenDetails() async {
    hideLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('My Circles'),
      ),
      body: Stack(
        children: <Widget>[
          getBody(),
          getLoaderWidget(),
          getErrorWidget(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }

  Widget getBody() {
    return GridView.count(
      crossAxisCount: 2,
      children: <Widget>[
        CircleCard(),
        CircleCard(),
        CircleCard(),
        CircleCard(),
        CircleCard(),
        CircleCard(),
        CircleCard(),
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
        callback: () => getMyCirclesScreenDetails(),
      ),
    );
  }

  showLoading() {
    appLogs("MyCirclesScreen:showLoading");

    setState(() => _pageState = PageState.Loading);
  }

  hideLoading() {
    appLogs("MyCirclesScreen:hideLoading");

    setState(() => _pageState = PageState.Loaded);
  }

  showError() {
    appLogs("MyCirclesScreen:showError");

    setState(() => _pageState = PageState.Error);
  }
}
