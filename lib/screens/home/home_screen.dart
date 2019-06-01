import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterhackathon/components/app_loading_widget.dart';
import 'package:flutterhackathon/utils/utils.dart';
import 'package:flutterhackathon/components/app_error_widget.dart';

import 'dart:ui' as ui;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> _scaffoldKey =
      new GlobalObjectKey<ScaffoldState>('HomeScreen');

  PageState _pageState = PageState.Loaded;
  String message = "";

  @override
  void initState() {
    super.initState();
    appLogs("HomeScreen", tag: "Screen");
    Future.delayed(
        Duration(milliseconds: 100), () => getHomeScreenDetails());

    new Timer(new Duration(milliseconds: 100), () {
      screenSize = MediaQuery.of(context).size;

      flyMenuFabCtrl = new AnimationController(
        vsync: this,
        duration: new Duration(milliseconds: animationDuration),
      );

      flyAnimCurve = new CurvedAnimation(
          parent: flyMenuFabCtrl, curve: Curves.fastOutSlowIn);

      flyMenuFabAnimY =
          new Tween(begin: 10.0, end: (screenSize.height / 2) - 25.0)
              .animate(flyAnimCurve)
                ..addListener(() {
                  setState(() {
                    fabY = flyMenuFabAnimY.value;
                  });
                });

      flyMenuFabAnimX =
          new Tween(begin: 10.0, end: (screenSize.width / 2) - 25.0)
              .animate(flyAnimCurve)
                ..addListener(() {
                  setState(() {
                    fabX = flyMenuFabAnimX.value;
                  });
                });

      menuBtnScaleCtrl = new AnimationController(
          vsync: this, duration: new Duration(milliseconds: animationDuration));

      menuBtnScaleCurve = new CurvedAnimation(
          parent: menuBtnScaleCtrl, curve: Curves.easeInOut);

      setState(() {
        isAllReady = true;
      });
    });
  }

  getHomeScreenDetails() async {
    hideLoading();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => new Future(
            () {
              if (isMenuOpen) {
                closeMenu();
                return false;
              } else
                return true;
            },
          ),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Feeds'),
        ),
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            getBody(),
            getLoaderWidget(),
            getErrorWidget(),
          ],
        ),
      ),
    );
  }

  Widget getBody() {
    return Stack(
      children: <Widget>[
        _body(),
        isMenuOpen
            ? new BackdropFilter(
                filter: new ui.ImageFilter.blur(
                  sigmaX: new Tween(begin: 0.0, end: 5.0)
                      .animate(flyAnimCurve)
                      .value,
                  sigmaY: new Tween(begin: 0.0, end: 5.0)
                      .animate(flyAnimCurve)
                      .value,
                ),
                child: new Center(
                  child: new Container(
                    height: screenSize.height,
                    width: screenSize.width,
                    color: new Color(0x00000000),
                  ),
                ),
              )
            : new Container(),
        _fab(),
        _menuBtn(
            title: 'Settings',
            icon: Icons.settings,
            top: (screenSize.height / 2) - 200.0,
            left: (screenSize.width / 2) - 50.0,
            onTap: () {
              print('Settings pressed');
            }),
        _menuBtn(
            title: 'Add Flat',
            icon: Icons.home,
            top: (screenSize.height / 2) - 20.0,
            left: (screenSize.width / 2) - 50.0,
            onTap: () {
              print('Add Flat pressed');
            }),
        _menuBtn(
            title: 'Add Tenant',
            icon: Icons.person_add,
            top: (screenSize.height / 2) - 110.0,
            left: (screenSize.width / 2) - 150.0,
            onTap: () {
              print('Add Tenant pressed');
            }),
        _menuBtn(
            title: 'Check',
            icon: Icons.check_circle,
            top: (screenSize.height / 2) - 110.0,
            left: (screenSize.width / 2) + 50.0,
            onTap: () {
              print('Check pressed');
            }),
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

  bool isMenuOpen = false;
  Animation<double> flyMenuFabAnimY;
  AnimationController flyMenuFabCtrl;
  Animation<double> flyMenuFabAnimX;
  CurvedAnimation flyAnimCurve;

  AnimationController menuBtnScaleCtrl;
  CurvedAnimation menuBtnScaleCurve;

  double fabX = 10.0;
  double fabY = 10.0;

  int animationDuration = 400;

  bool isAllReady = false;

  Size screenSize = new Size(0.0, 0.0);

  void dispose() {
    flyMenuFabCtrl.dispose();
    super.dispose();
  }

  void openMenu() {
    setState(() {
      isMenuOpen = true;
    });

    flyMenuFabCtrl.forward().then((_) {
      menuBtnScaleCtrl.forward();
    });

    print('Menu Opened');
  }

  void closeMenu() {
    menuBtnScaleCtrl.reverse().then((_) {
      flyMenuFabCtrl.reverse().then((_) {
        setState(() {
          isMenuOpen = false;
        });
      });
    });

    print('Menu Closed');
  }

  Widget _body() {
    return new ListView(
      children: <Widget>[
        Text('YUHU')
      ],
    );
  }

  Widget _fab() {
    return new Positioned(
      child: new FloatingActionButton(
        onPressed: () {
          if (isMenuOpen)
            closeMenu();
          else
            openMenu();
        },
        child: isAllReady
            ? new RotationTransition(
                child: isMenuOpen
                    ? new Icon(Icons.close)
                    : new Icon(Icons.clear_all),
                turns: new Tween(begin: 0.0, end: 0.25).animate(flyAnimCurve))
            : new Container(),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white70,
      ),
      bottom: fabY,
      left: fabX,
    );
  }

  Widget _menuBtn(
      {String title,
      double top,
      double left,
      IconData icon,
      GestureTapCallback onTap}) {
    return new Positioned(
      child: isAllReady
          ? new ScaleTransition(
              scale: new Tween(begin: 0.0, end: 1.0).animate(menuBtnScaleCurve),
              child: new InkWell(
                child: new Container(
                  width: 100.0,
                  child: new Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new Icon(
                        icon,
//                      color: Colors.white70,
                      ),
                      new Text(
                        title,
                        style: new TextStyle(
                            fontSize: 15.0, color: Colors.white70),
                      )
                    ],
                  ),
                  padding: new EdgeInsets.all(5.0),
                  decoration: new BoxDecoration(
                      color: new Color(0x99555555),
                      borderRadius:
                          new BorderRadius.all(new Radius.circular(20.0))),
                ),
                onTap: onTap,
              ),
            )
          : new Container(),
      top: top,
      left: left,
    );
  }
}
