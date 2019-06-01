import 'package:flutter/material.dart';
import 'package:flutterhackathon/Theme/theme.dart';
import 'package:flutterhackathon/Utils/utils.dart';
import 'package:flutterhackathon/components/app_alerts.dart';

class AppErrorWidget extends StatelessWidget {
  final String message;
  final String buttonText;
  final GestureTapCallback callback;
  final Widget child;
  final bool showButton;

  const AppErrorWidget({
    Key key,
    @required this.message,
    this.buttonText,
    @required this.callback,
    this.child,
    this.showButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (child != null) {
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[child],
        ),
      );
    }

    return Container(
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(Sizes.s8),
            child: Image(
              image: AssetImage(Assets.alertError),
              height: Sizes.defaultCardHeight,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(Sizes.s10),
            child: Text(
              message,
              style: TextStyles.alertText,
              textAlign: TextAlign.center,
            ),
          ),
          showButton
              ? AlertButton(
                  buttonType: ButtonType.positiveButton,
                  text: buttonText ?? Strings.retry,
                  callback: callback ?? () {},
                )
              : Container(),
        ],
      ),
    );
  }
}
