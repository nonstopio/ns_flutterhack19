import 'package:flutter/material.dart';
import 'package:flutterhackathon/components/app_button.dart';
import 'package:flutterhackathon/components/app_error_widget.dart';
import 'package:flutterhackathon/components/app_image.dart';
import 'package:flutterhackathon/components/app_loading_widget.dart';
import 'package:flutterhackathon/models/models.dart';
import 'package:flutterhackathon/services/auth.dart';
import 'package:flutterhackathon/services/firebase.dart';
import 'package:flutterhackathon/theme/app_assets.dart';
import 'package:flutterhackathon/theme/app_decorations.dart';
import 'package:flutterhackathon/utils/utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddExpenseScreen extends StatefulWidget {
  final String circleId;

  const AddExpenseScreen({Key key, this.circleId}) : super(key: key);

  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey =
      new GlobalObjectKey<ScaffoldState>('AddExpenseScreen');

  Expense _expense = Expense.empty();

  PageState _pageState = PageState.Loading;
  String message = "";

  final _form = GlobalKey<FormState>();

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
              onChanged: (value) {
                setState(() {
                  _expense.amount = value;
                });
              },
              decoration: AppDecorations.input(
                label: 'Amount',
                hintText: 'Enter the amount spending',
                error: null,
              ),
              keyboardType: TextInputType.number,
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
          child: Form(
            key: _form,
            child: ListView(
              children: <Widget>[
                _buidlTopWidget(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        _expense.description = value;
                      });
                    },
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
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: AppButton(
            title: 'Add',
            onTap: () async {
              _form.currentState.save();

              appLogs(toDouble(_expense.amount));
              appLogs(_expense.description);

              if (toDouble(_expense.amount) == 0 ||
                  _expense.description.isEmpty) {
                AppToast.showError("Error");
                return;
              }

              await circleExpenseRef.child(widget.circleId).push().set({
                Strings.amount: _expense.amount,
                Strings.description: _expense.description,
                Strings.createdBy: auth.currentUser.uid,
                Strings.image: auth.currentUser.profileImageUrl,
                Strings.name: auth.currentUser.name,
                Strings.like: _expense.like,
                Strings.dislike: _expense.dislike,
              });

              AppToast.showSuccess("Added");
              AppRoutes.pop(context);

              //TODO:send notification
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

class ExpenseWidget extends StatelessWidget {
  final Expense expense;
  final String circleId;

  const ExpenseWidget({Key key, @required this.expense, this.circleId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Sizes.s8),
      margin: EdgeInsets.all(Sizes.s8),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 20.0,
          )
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              AppCircularImage(
                imageURL: expense.image,
                radius: 30.0,
              ),
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    expense.description,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  moneyFormat(
                    value: toDouble(
                      expense.amount,
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 30.0,
                  ),
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(FontAwesomeIcons.thumbsUp),
                onPressed: () async {
                  double total = toDouble((await circleExpenseRef
                              .child(circleId)
                              .child(expense.id)
                              .child(Strings.like)
                              .once())
                          .value) ??
                      0;
                  total = total + 1;
                  await circleExpenseRef
                      .child(circleId)
                      .child(expense.id)
                      .update({Strings.like: "$total"});
                  AppToast.showSuccess("Liked");
                },
              ),
              // P10(),
              Text(
                likeFormat(
                  value: toDouble(expense.like),
                ),
              ),
              P10(),
              IconButton(
                icon: Icon(FontAwesomeIcons.thumbsDown),
                onPressed: () async {
                  double total = toDouble((await circleExpenseRef
                              .child(circleId)
                              .child(expense.id)
                              .child(Strings.dislike)
                              .once())
                          .value) ??
                      0;
                  total = total + 1;
                  await circleExpenseRef
                      .child(circleId)
                      .child(expense.id)
                      .update({Strings.dislike: "$total"});
                  AppToast.showSuccess("Liked");
                },
              ),
              // P10(),
              Text(likeFormat(value: toDouble(expense.dislike))),
            ],
          ),
        ],
      ),
    );
  }
}
