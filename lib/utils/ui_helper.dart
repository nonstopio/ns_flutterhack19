import 'package:flutter/material.dart';
import 'package:flutterhackathon/theme/theme.dart';
import 'package:flutterhackathon/utils/utils.dart';

class DashedLineWidget extends StatelessWidget {
  final int dashNumber;

  const DashedLineWidget({Key key, this.dashNumber = 20}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Sizes.s30, vertical: Sizes.s10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(dashNumber, (index) {}).map((value) {
          return Container(
            height: Sizes.s2,
            width: Sizes.s5,
            color: Colors.grey,
          );
        }).toList(),
      ),
    );
  }
}

class C50 extends StatelessWidget {
  final Color color;

  const C50({Key key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? Colors.transparent,
      height: Sizes.s50,
      width: Sizes.s50,
    );
  }
}

class C30 extends StatelessWidget {
  final Color color;

  const C30({Key key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? Colors.transparent,
      height: Sizes.s30,
      width: Sizes.s30,
    );
  }
}

class C0 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }
}

class C10 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Sizes.s10,
      width: Sizes.s10,
    );
  }
}

class C5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Sizes.s5,
      width: Sizes.s5,
    );
  }
}

class AppVersion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        App.versionName,
        style: TextStyles.defaultLight,
      ),
    );
  }
}

class DevWidget extends StatelessWidget {
  final String value;

  const DevWidget({Key key, @required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!App.devMode) return C0();
    return Container(
      padding: EdgeInsets.all(Sizes.s5),
      color: Colors.black,
      child: Row(
        children: <Widget>[
          Text(
            "DM:",
            style: TextStyles.defaultBold.copyWith(
              color: Colors.white,
            ),
          ),
          Expanded(
            child: Text(
              "$value",
              style: TextStyles.defaultLight.copyWith(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class P1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(Sizes.s1));
  }
}

class P2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(Sizes.s2));
  }
}

class P10 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(Sizes.s10));
  }
}

class PH10 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.symmetric(horizontal: Sizes.s10));
  }
}

class P5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(Sizes.s5));
  }
}

class P20 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(Sizes.s20));
  }
}

class P30 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(Sizes.s30));
  }
}

class C1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Sizes.s1,
      width: Sizes.s1,
    );
  }
}

class C2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Sizes.s2,
      width: Sizes.s2,
    );
  }
}
