import 'package:flutter/material.dart';
import 'package:flutterhackathon/models/models.dart';
import 'package:flutterhackathon/theme/app_assets.dart';
import 'package:flutterhackathon/utils/app_size.dart';
// import 'package:kingdom/dialogs/kingdom_options.dart';

class CircleCard extends StatefulWidget {
  final CircleModel circle;
  final Function onTap;

  const CircleCard({Key key, @required this.circle, this.onTap}) : super(key: key);

  @override
  _CircleCardState createState() => new _CircleCardState();
}

class _CircleCardState extends State<CircleCard> {
  double circleCardHeight = 120.0;
  double circleCardWidth = 140.0;
  double personTopSpace = 20.0;
  double personAvatarRadius = 50.0;

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      child: new Center(
        child: new Container(
          margin: EdgeInsets.all(Sizes.s8),
          child: new Stack(
            children: <Widget>[
              new Positioned(
                child: new Container(
                  decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.all(
                      new Radius.circular(10.0),
                    ),
                    color: Theme.of(context).accentColor,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 20.0,
                        color: Colors.black38,
                      )
                    ],
                  ),
                  constraints: new BoxConstraints(
                    minHeight: circleCardHeight,
                    minWidth: circleCardWidth,
                  ),
                ),
                left: 0.0,
                top: personTopSpace,
              ),
              new Positioned(
                child: new CircleAvatar(
                  backgroundImage: new AssetImage(Assets.tempGroupPhoto),
                  radius: personAvatarRadius,
                ),
                left: (circleCardWidth / 2) - personAvatarRadius,
                top: 0.0,
              ),
              new Positioned(
                child: Center(
                  child: new Text(
                    widget.circle.name,
                    style: new TextStyle(color: Colors.white),
                  ),
                ),
                left: 0.0,
                top: (personAvatarRadius * 2) + 10.0,
                width: circleCardWidth,
              )
            ],
          ),
          height: circleCardHeight + personTopSpace,
          width: circleCardWidth,
        ),
      ),
      onTap: widget.onTap,
    );
  }
}
