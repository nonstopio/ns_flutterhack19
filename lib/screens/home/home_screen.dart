import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutterhackathon/components/app_error_widget.dart';
import 'package:flutterhackathon/components/app_image.dart';
import 'package:flutterhackathon/components/app_loading_widget.dart';
import 'package:flutterhackathon/components/app_recactive_widget.dart';
import 'package:flutterhackathon/components/circle_card.dart';
import 'package:flutterhackathon/models/circle_model.dart';
import 'package:flutterhackathon/services/firebase.dart';
import 'package:flutterhackathon/services/services.dart';
import 'package:flutterhackathon/utils/utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalObjectKey<ScaffoldState>('HomeScreen');

  PageState _pageState = PageState.Loading;
  String message = "";

  String _selectedCircleId = "";

  @override
  void initState() {
    super.initState();
    appLogs("HomeScreen", tag: "Screen");
    Future.delayed(Duration(milliseconds: 100), () => getHomeScreenDetails());
  }

  getHomeScreenDetails() async {
    DataSnapshot dataSnapshot = await userCircleRef.child(auth.currentUser.uid).once();
    if (dataSnapshot.value != null) {
      appLogs(dataSnapshot.value);

      Map data = dataSnapshot.value;

      _selectedCircleId = data.keys.first;

      setState(() {});
    }

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

  Widget _getCircleWidget() {
    return Container(
      height: Sizes.screenWidthHalf,
      child: ReactiveWidget<Map>(
        reactiveRef: getMyCircles(),
        widgetBuilder: (Map data) {
          if (data != null) {
            List<CircleModel> _circleList = [];

            data.forEach((k, v) {
              _circleList.add(CircleModel.fromMap(data: v, id: k));
            });

            return ListView(
              scrollDirection: Axis.horizontal,
              children: _circleList.map((circleData) {
                return CircleCard(
                  circle: circleData,
                  onTap: () async {
                    setState(() {
                      _selectedCircleId = circleData.id;
                    });
                  },
                );
              }).toList(),
            );
          }

          return Container();
        },
        fallbackValue: Map(),
      ),
    );
  }

  _getFeedWidget() {
    return Flexible(
      child: FirebaseAnimatedList(
        shrinkWrap: true,
        itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation animation, int index) {
          if (snapshot.value != null) {
            print("getPaymentHistory ${snapshot.value}");
            return Container();
          }

          return C0();
        },
        query: getCircleFeed(_selectedCircleId),
        defaultChild: CircularProgressIndicator(),
      ),
    );
  }

  Widget getBody() {
    return Column(
      children: <Widget>[
        _getCircleWidget(),
        _getFeedWidget(),
        Container(
          padding: EdgeInsets.all(Sizes.s8),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  AppCircularImage(
                    imageURL:
                        "https://images.pexels.com/photos/414612/pexels-photo-414612.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                  ),
                  Expanded(
                      flex: 2,
                      child: Container(
                        child: Text(
                          "Description",
                        ),
                      )),
                  Expanded(
                    flex: 1,
                    child: Text(
                      moneyFormat(
                        value: toDouble(
                          "123",
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(FontAwesomeIcons.thumbsUp),
                          onPressed: () {},
                        ),
                        P10(),
                        Text("100")
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(FontAwesomeIcons.thumbsDown),
                          onPressed: () {},
                        ),
                        P10(),
                        Text("100")
                      ],
                    ),
                  ),
                ],
              ),
            ],
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
