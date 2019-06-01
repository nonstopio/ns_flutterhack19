import 'package:flutter/material.dart';
import 'package:flutterhackathon/theme/app_textstyle.dart';
import 'package:flutterhackathon/theme/theme.dart';
import 'package:flutterhackathon/utils/utils.dart';

class AppButton extends StatelessWidget {
  final String title;
  final Widget child;
  final GestureTapCallback onTap;
  final double height;
  final double width;
  final bool enabled;
  final bool full;
  final Color color;

  AppButton({
    @required this.onTap,
    this.title,
    this.height = 45.0,
    this.width,
    this.enabled = true,
    this.color = AppColors.primary,
    this.child,
    this.full = false,
  })  : assert(title == null || child == null, 'Cannot provide both a title and a child'),
        assert(title != null || child != null, 'title and a child both cannot be null');

  @override
  Widget build(BuildContext context) {
    Widget textWidget = Center(
      child: Text(
        title,
        style: (color != Colors.white)
            ? TextStyles.buttonText
            : TextStyles.buttonText.copyWith(
                color: Colors.black,
              ),
      ),
    );

    return Container(
      margin: EdgeInsets.symmetric(horizontal: Sizes.s20),
      height: height,
      width: full ? screenWidth - 100 : width,
      decoration: BoxDecoration(
        border: Border.all(
          color: (color == Colors.white ? Colors.black : (enabled ? color : Colors.grey)),
        ),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: FlatButton(
        color: enabled ? color : Colors.grey,
        shape: BeveledRectangleBorder(),
        onPressed: enabled ? onTap : () {},
        child: child ?? full
            ? Row(
                children: <Widget>[
                  Expanded(
                    child: textWidget,
                  )
                ],
              )
            : textWidget,
      ),
    );
  }
}

class AppProfileButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final Widget image;

  const AppProfileButton({Key key, @required this.onTap, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        InkResponse(
          child: Container(
            child: image,
            constraints: BoxConstraints.tightFor(width: 130.0, height: 130.0),
            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
            padding: EdgeInsets.all(8.0),
          ),
          onTap: onTap,
        ),
      ],
    );
  }
}

class AppImageButton extends StatelessWidget {
  final Color color;
  final String image;
  final GestureTapCallback onTap;

  const AppImageButton({
    Key key,
    this.color,
    @required this.image,
    @required this.onTap,
  })  : assert(image != null && image != ""),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(Sizes.s10),
        child: Image(
          image: AssetImage(
            image,
          ),
          color: color ?? Colors.white,
          height: Sizes.s20,
        ),
      ),
    );
  }
}

class AppTextButton extends StatelessWidget {
  final String title;
  final GestureTapCallback onTap;

  const AppTextButton({Key key, this.title, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: onTap,
        child: Text(
          title,
          style: TextStyles.buttonText.copyWith(
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}

class AppIconTextButton extends StatelessWidget {
  final String title;
  final Function onTap;
  final IconData icon;

  const AppIconTextButton({Key key, @required this.title, @required this.onTap, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Sizes.s50),
            color: AppColors.primary,
          ),
          padding: EdgeInsets.all(Sizes.s5),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                icon ?? Icons.filter_list,
                color: Colors.white,
              ),
              C2(),
              Text(
                title,
                style: TextStyles.defaultRegular.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
