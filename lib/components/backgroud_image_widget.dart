import 'package:flutter/material.dart';
import 'package:flutterhackathon/Theme/theme.dart';
import 'package:flutterhackathon/Utils/app_size.dart';

class BackgroundImageWidget extends StatelessWidget {
  final String image;
  final Widget child;
  final double height;
  final double width;

  const BackgroundImageWidget({
    Key key,
    this.image,
    this.child,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.3,
      child: Container(
        height: height ?? screenHeight,
        width: width ?? screenWidth,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(image ?? Assets.doodle),
            fit: BoxFit.contain,
            repeat: ImageRepeat.repeat,
          ),
        ),
        child: child,
      ),
    );
  }
}

class BackgroundWidget extends StatelessWidget {
  final String image;
  final Widget child;

  const BackgroundWidget({
    Key key,
    this.image = Assets.bgScreen,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight,
      width: screenWidth,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.fitWidth,
        ),
      ),
      child: child,
    );
  }
}
