import 'package:flutter/material.dart';
import 'package:flutterhackathon/components/app_loading_widget.dart';
import 'package:flutterhackathon/components/user_card.dart';
import 'package:flutterhackathon/theme/app_assets.dart';
import 'package:flutterhackathon/theme/app_decorations.dart';
import 'package:flutterhackathon/utils/utils.dart';
import 'package:flutterhackathon/components/app_error_widget.dart';

class AddCircleScreen extends StatefulWidget {
  @override
  _AddCircleScreenState createState() => _AddCircleScreenState();
}

class _AddCircleScreenState extends State<AddCircleScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey =
      new GlobalObjectKey<ScaffoldState>('AddCircleScreen');

  PageState _pageState = PageState.Loading;
  String message = "";

  @override
  void initState() {
    super.initState();
    appLogs("AddCircleScreen", tag: "Screen");
    Future.delayed(
        Duration(milliseconds: 500), () => getAddCircleScreenDetails());
  }

  getAddCircleScreenDetails() async {
    hideLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('New Circle'),
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
    return ListView(
      children: <Widget>[
        _buidlTopWidget(),
        Divider(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Members',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        UserCard(
          child: Center(
            child: Text(
              'Arnold Parge',
              style: TextStyle(
                color: Colors.grey[200],
                fontSize: 20.0,
              ),
            ),
          ),
          image: Assets.tempGroupPhoto,
          height: 70.0,
        )
      ],
    );
  }

  Row _buidlTopWidget() {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage(Assets.tempGroupPhoto),
            radius: 50.0,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: AppDecorations.input(
                label: 'Circle Name',
                hintText: 'Enter new circle name',
                error: null,
              ),
            ),
          ),
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
