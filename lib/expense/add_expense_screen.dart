import 'package:flutter/material.dart';
import 'package:flutterhackathon/components/app_button.dart';
import 'package:flutterhackathon/components/app_loading_widget.dart';
import 'package:flutterhackathon/theme/app_assets.dart';
import 'package:flutterhackathon/theme/app_decorations.dart';
import 'package:flutterhackathon/utils/utils.dart';
import 'package:flutterhackathon/components/app_error_widget.dart';

class AddExpenseScreen extends StatefulWidget {
  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey =
      new GlobalObjectKey<ScaffoldState>('AddExpenseScreen');

  PageState _pageState = PageState.Loading;
  String message = "";

  @override
  void initState() {
    super.initState();
    appLogs("AddExpenseScreen", tag: "Screen");
    Future.delayed(
        Duration(milliseconds: 500), () => getAddExpenseScreenDetails());
  }

  getAddExpenseScreenDetails() async {
    hideLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Add Expense'),
      ),
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
                label: 'Amount',
                hintText: 'Enter the amount spending',
                error: null,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget getBody() {
    return Column(
      children: <Widget>[
        Flexible(
          child: ListView(
            children: <Widget>[
              _buidlTopWidget(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: AppDecorations.input(
                    label: 'Description',
                    hintText: 'Enter the description of the expense',
                    error: null,
                  ),
                  maxLines: 5,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: AppButton(
            title: 'Add',
            onTap: () {
              
            },
          ),
        ),
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
        callback: () => getAddExpenseScreenDetails(),
      ),
    );
  }

  showLoading() {
    appLogs("AddExpenseScreen:showLoading");

    setState(() => _pageState = PageState.Loading);
  }

  hideLoading() {
    appLogs("AddExpenseScreen:hideLoading");

    setState(() => _pageState = PageState.Loaded);
  }

  showError() {
    appLogs("AddExpenseScreen:showError");

    setState(() => _pageState = PageState.Error);
  }
}
