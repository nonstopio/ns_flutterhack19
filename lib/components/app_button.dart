import 'package:flutter/material.dart';
import 'package:flutterhackathon/Theme/theme.dart';
import 'package:flutterhackathon/Utils/utils.dart';

class AppButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final String text;
  final Color color;
  final BorderRadius _borderRadius = BorderRadius.all(
    Radius.circular(Sizes.s10),
  );

  final bool enabled;

  AppButton({
    @required this.onTap,
    @required this.text,
    this.enabled = true,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: _borderRadius,
      onTap: enabled ? onTap : () {},
      child: Container(
        padding: EdgeInsets.all(Sizes.s10),
        child: Center(
          child: Text(
            text,
            style: TextStyles.buttonText,
            textAlign: TextAlign.center,
          ),
        ),
        decoration: BoxDecoration(
          color: enabled ? color ?? AppColors.primary : AppColors.greyish,
          borderRadius: _borderRadius,
        ),
      ),
    );
  }
}

class AppIconTextButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final String text;
  final IconData icon;
  final Color color;
  final BorderRadius _borderRadius = BorderRadius.all(
    Radius.circular(9.0),
  );

  final bool enabled;

  AppIconTextButton({
    @required this.onTap,
    @required this.text,
    this.enabled = true,
    this.icon = Icons.edit,
    this.color = AppColors.secondary,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: _borderRadius,
      onTap: enabled ? onTap : () {},
      child: Container(
        padding: EdgeInsets.all(Sizes.s10),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              color: enabled ? color : AppColors.greyish,
            ),
            Container(
              width: 2.0,
            ),
            Text(
              text,
              style: TextStyles.buttonText.copyWith(
                color: color,
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: enabled ? AppColors.white : AppColors.greyish,
          borderRadius: _borderRadius,
        ),
      ),
    );
  }
}

class ReplyButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const ReplyButton({Key key, @required this.onPressed, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.all(
        Radius.circular(Sizes.s20),
      ),
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.all(Sizes.s5),
        padding: EdgeInsets.symmetric(horizontal: Sizes.s15, vertical: Sizes.s10),
        decoration: BoxDecoration(
            color: Colors.grey[400],
            borderRadius: BorderRadius.all(
              Radius.circular(Sizes.s20),
            ),
            boxShadow: [BoxShadow(color: Colors.grey[400], blurRadius: Sizes.s5)]),
        child: Text(
          "$text",
          style: TextStyles.inputButtonText,
        ),
      ),
    );
  }
}
