import 'package:flutter/material.dart';
import 'package:flutterhackathon/Theme/app_assets.dart';
// import 'package:kingdom/dialogs/kingdom_options.dart';

class CircleCard extends StatefulWidget {
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
                    'Jenny',
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
      onTap: () {
        // kingdomOptions(
        //     context: context,
        //     kingdomOptionsDetails: [
        //         {
        //             "icon": Icons.person,
        //             "text": 'View Profile',
        //         },
        //         {
        //             "icon": Icons.restore_from_trash,
        //             "text": 'Hide Post',
        //         },
        //         {
        //             "icon": Icons.report,
        //             "text": 'Report Abuse',
        //         },
        //         {
        //             "icon": Icons.cancel,
        //             "text": 'Cancel',
        //             "onTap": () {
        //                 Navigator.of(context, rootNavigator: true).pop();
        //             }
        //         },
        //     ]
        // );
      },
    );
  }
}
