import 'package:flutter/material.dart';
import 'package:flutterhackathon/Theme/theme.dart';

class BackgroundGradientWidget extends StatelessWidget {
  final Widget child;

  const BackgroundGradientWidget({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.gredientOne, AppColors.gredientTwo],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: child,
    );
  }
}
