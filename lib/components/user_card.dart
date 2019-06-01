import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class UserCard extends StatelessWidget {
  final double height;
  final double _padding = 10.0;
  final Widget child;
  final String image;

  UserCard({
    this.height = 100.0,
    @required this.child,
    @required this.image,
  });

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return new Container(
      child: new Stack(
        children: <Widget>[
          new Positioned(
            child: new Container(
              width: _width,
              height: height,
              decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.all(
                    new Radius.circular(10.0),
                  ),
                  color: Theme.of(context).primaryColor),
              child: child,
              padding: new EdgeInsets.only(
                left: height / 2,
                top: _padding,
                bottom: _padding,
                right: _padding,
              ),
            ),
            left: height / 2,
            width: (_width - (height / 2)) - (_padding * 2),
          ),
          new Positioned(
            child: new Container(
              child: new CircleAvatar(
                radius: (height / 2) - (_padding),
                backgroundImage: new AssetImage(image),
              ),
              decoration: new BoxDecoration(
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.black38,
                      blurRadius: 10.0,
                    )
                  ],
                  borderRadius:
                      new BorderRadius.all(new Radius.circular(height))),
            ),
            top: _padding,
            left: _padding,
          )
        ],
      ),
      padding: new EdgeInsets.all(_padding),
      height: height + (_padding * 2),
    );
  }
}
