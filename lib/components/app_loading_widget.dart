import 'package:flutter/material.dart';
import 'package:flutterhackathon/Utils/utils.dart';


class FullScreenLoader extends StatelessWidget {
  FullScreenLoader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.white70,
      child: new Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.all(Sizes.s20),
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }
}
