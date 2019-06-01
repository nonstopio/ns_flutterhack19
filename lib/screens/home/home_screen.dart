import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutterhackathon/components/app_error_widget.dart';
import 'package:flutterhackathon/components/app_loading_widget.dart';
import 'package:flutterhackathon/components/app_recactive_widget.dart';
import 'package:flutterhackathon/components/circle_card.dart';
import 'package:flutterhackathon/expense/add_expense_screen.dart';
import 'package:flutterhackathon/models/models.dart';
import 'package:flutterhackathon/services/firebase.dart';
import 'package:flutterhackathon/services/services.dart';
import 'package:flutterhackathon/utils/utils.dart';

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
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            AppRoutes.push(
                context,
                AddExpenseScreen(
                  circleId: _selectedCircleId,
                ));
          }),
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

                    appLogs("Circle Id Selected");
                    appLogs(_selectedCircleId);
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

  Widget _getExpenseWidget() {
    return Flexible(
      child: ReactiveWidget<Map>(
        reactiveRef: getMyCirclesFeed(_selectedCircleId),
        widgetBuilder: (Map data) {
          if (data != null) {
            List<Expense> _expenseList = [];

            data.forEach((k, value) {
              _expenseList.add(Expense.fromMap(data: value, id: k));
            });

            return ListView(
              children: _expenseList.map((expense) {
                return ExpenseWidget(expense: expense, circleId: _selectedCircleId);
              }).toList(),
            );
          }

          return Container();
        },
        fallbackValue: Map(),
      ),
    );
  }

  Widget getBody() {
    return Column(
      children: <Widget>[
        _getCircleWidget(),
        _getExpenseWidget(),
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
