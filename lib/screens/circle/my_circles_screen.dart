import 'package:flutter/material.dart';
import 'package:flutterhackathon/components/app_error_widget.dart';
import 'package:flutterhackathon/components/app_loading_widget.dart';
import 'package:flutterhackathon/components/app_recactive_widget.dart';
import 'package:flutterhackathon/components/circle_card.dart';
import 'package:flutterhackathon/models/models.dart';
import 'package:flutterhackathon/screens/circle/add_circle_screen.dart';
import 'package:flutterhackathon/services/firebase.dart';
import 'package:flutterhackathon/utils/utils.dart';

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
        onPressed: () {
          AppRoutes.push(context, AddCircleScreen());
        },
      ),
    );
  }

  Widget getBody() {
    return ReactiveWidget<Map>(
      reactiveRef: getMyCircles(),
      widgetBuilder: (Map data) {
        if (data != null) {
          List<CircleModel> _circleList = [];

          data.forEach((k, v) {
            _circleList.add(CircleModel.fromMap(data: v, id: k));
          });

          return GridView.count(
            crossAxisCount: 2,
            children: _circleList.map((circleData) {
              return CircleCard(
                circle: circleData,
                onTap: () async {
                  // setState(() {
                  //   _selectedCircleId = circleData.id;
                  // });
                },
              );
            }).toList(),
          );
        }

        return Container();
      },
      fallbackValue: Map(),
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
