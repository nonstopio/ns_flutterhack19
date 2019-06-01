import 'package:flutter/material.dart';
import 'package:flutterhackathon/Theme/theme.dart';
import 'package:flutterhackathon/Utils/utils.dart';

class FontFamily {
  static const String regular = "PollyRounded-Regular";
  static const String bold = "PollyRounded-Bold";
  static const String light = "PollyRounded-Light";
  static const String thin = "PollyRounded-Thin";
}

class TextStyles {
  static TextDecoration underline = TextDecoration.underline;
  static TextDecoration lineThrough = TextDecoration.lineThrough;

  static TextStyle get appBarTitle => TextStyle(
        fontFamily: FontFamily.bold,
        fontSize: FontSize.s19,
        color: Colors.white,
        letterSpacing: 1.60,
        textBaseline: TextBaseline.alphabetic,
        inherit: false,
      );

  static TextStyle get alertText => TextStyle(
        fontFamily: FontFamily.regular,
        fontSize: FontSize.s20,
        color: Colors.black,
        letterSpacing: 0.60,
        textBaseline: TextBaseline.alphabetic,
        inherit: false,
      );

  static TextStyle get snackBarTitle => TextStyle(
        fontFamily: FontFamily.light,
        fontSize: FontSize.s15,
        color: Colors.white,
        letterSpacing: 0.60,
        textBaseline: TextBaseline.alphabetic,
        inherit: false,
      );

  static TextStyle get alertButtonText => TextStyle(
        fontFamily: FontFamily.bold,
        fontSize: FontSize.s14,
        color: AppColors.greyish,
        letterSpacing: 1.4,
        textBaseline: TextBaseline.alphabetic,
        inherit: false,
      );

  static TextStyle get welcomeTitle => TextStyle(
        fontFamily: FontFamily.bold,
        fontSize: FontSize.s25,
        color: Colors.white,
        textBaseline: TextBaseline.alphabetic,
        inherit: false,
      );

  static TextStyle get welcomeSubTitle => TextStyle(
        fontFamily: FontFamily.light,
        fontSize: FontSize.s18,
        color: Colors.white,
        textBaseline: TextBaseline.alphabetic,
        inherit: false,
      );

  static TextStyle get courseName => TextStyle(
        fontFamily: FontFamily.regular,
        fontSize: FontSize.s18,
        color: AppColors.lightBlack,
        textBaseline: TextBaseline.alphabetic,
        inherit: false,
      );

  static TextStyle get medalCount => TextStyle(
        fontFamily: FontFamily.light,
        fontSize: FontSize.s12,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
        textBaseline: TextBaseline.alphabetic,
        inherit: false,
      );

  static TextStyle get courseSubtitle => TextStyle(
        fontFamily: FontFamily.regular,
        fontSize: FontSize.s15,
        color: AppColors.grey,
        textBaseline: TextBaseline.alphabetic,
        inherit: false,
      );

  static TextStyle get courseDiscountPrice => TextStyle(
        fontFamily: FontFamily.regular,
        fontSize: FontSize.s18,
        color: AppColors.greyish,
        textBaseline: TextBaseline.alphabetic,
        inherit: false,
        decoration: lineThrough,
      );

  static TextStyle get buttonText => TextStyle(
        fontFamily: FontFamily.bold,
        fontSize: FontSize.s18,
        color: Colors.white,
        textBaseline: TextBaseline.alphabetic,
        inherit: false,
      );

  static TextStyle get smallButtonText => TextStyle(
        fontFamily: FontFamily.bold,
        fontSize: FontSize.s12,
        color: Colors.white,
        textBaseline: TextBaseline.alphabetic,
        inherit: false,
      );

  static TextStyle get inputButtonText => TextStyle(
        fontFamily: FontFamily.light,
        fontSize: FontSize.s14,
        color: Colors.black,
        textBaseline: TextBaseline.alphabetic,
        inherit: false,
      );

  static TextStyle get gradingScaleTitle => TextStyle(
        fontFamily: FontFamily.bold,
        fontSize: FontSize.s25,
        color: Colors.black,
        textBaseline: TextBaseline.alphabetic,
        inherit: false,
      );

  static TextStyle get grade => TextStyle(
        fontFamily: FontFamily.bold,
        fontSize: FontSize.s20,
        color: Colors.black,
        textBaseline: TextBaseline.alphabetic,
        inherit: false,
      );

  static TextStyle get subHeading => TextStyle(
        color: AppColors.brownishGrey,
        fontFamily: FontFamily.regular,
        fontSize: FontSize.s18,
      );

  static TextStyle get karmaText => TextStyle(
        color: AppColors.brownishGrey,
        fontFamily: FontFamily.regular,
        fontSize: FontSize.s16,
      );

  static TextStyle get gradeDescription => TextStyle(
        fontFamily: FontFamily.regular,
        fontSize: FontSize.s18,
        color: Colors.grey,
        textBaseline: TextBaseline.alphabetic,
        inherit: false,
      );

  static TextStyle get optionText => TextStyle(
        fontFamily: FontFamily.regular,
        fontSize: FontSize.s14,
        color: Color(0xFFEEEEEE),
        textBaseline: TextBaseline.alphabetic,
        inherit: false,
      );

  static TextStyle get editText => TextStyle(
        fontFamily: FontFamily.regular,
        fontSize: FontSize.s16,
        color: AppColors.charcoalGrey,
        textBaseline: TextBaseline.alphabetic,
        inherit: false,
      );

  static TextStyle get editNumber => TextStyle(
        fontFamily: FontFamily.regular,
        fontSize: FontSize.s16,
        color: AppColors.brownishGrey,
        textBaseline: TextBaseline.alphabetic,
        inherit: false,
        letterSpacing: 5,
      );

  static TextStyle get labelStyle => TextStyle(
        fontFamily: FontFamily.regular,
        fontSize: FontSize.s16,
        color: AppColors.grey,
        textBaseline: TextBaseline.alphabetic,
        inherit: false,
      );

  static TextStyle get profileText => TextStyle(
        fontSize: FontSize.s16,
        fontFamily: FontFamily.regular,
        color: AppColors.darkGrey,
        letterSpacing: 0.33,
        textBaseline: TextBaseline.alphabetic,
        inherit: false,
      );

  static TextStyle get headingTitle => TextStyle(
        fontSize: FontSize.s18,
        fontFamily: FontFamily.bold,
        color: AppColors.lightBlack,
        letterSpacing: 0.88,
        textBaseline: TextBaseline.alphabetic,
        inherit: false,
      );

  static TextStyle get tabTitle => TextStyle(
        fontSize: FontSize.s10,
        fontFamily: FontFamily.regular,
        color: AppColors.charcoalGrey,
        letterSpacing: 1,
        textBaseline: TextBaseline.alphabetic,
        inherit: false,
      );

  static TextStyle get profileLabel => TextStyle(
        fontSize: FontSize.s14,
        fontFamily: FontFamily.regular,
        color: Color(0xFF909090),
        letterSpacing: 0.33,
        textBaseline: TextBaseline.alphabetic,
        inherit: false,
      );

  static TextStyle get errorStyle => TextStyle(
        fontFamily: FontFamily.bold,
        fontSize: FontSize.s12,
        color: AppColors.red,
        textBaseline: TextBaseline.alphabetic,
        inherit: false,
      );

  static TextStyle get webinarHeader => TextStyle(
        fontFamily: FontFamily.bold,
        fontSize: FontSize.s20,
        color: Colors.white,
        textBaseline: TextBaseline.alphabetic,
        inherit: false,
      );

  static TextStyle get webinarGrade => TextStyle(
        fontFamily: FontFamily.bold,
        fontSize: FontSize.s14,
        color: Colors.white,
        textBaseline: TextBaseline.alphabetic,
        inherit: false,
      );

  static TextStyle get link => TextStyle(
        fontFamily: FontFamily.bold,
        fontSize: FontSize.s20,
        color: Colors.blue,
        textBaseline: TextBaseline.alphabetic,
        inherit: false,
      );

  static TextStyle get specialities => TextStyle(
        fontFamily: FontFamily.bold,
        fontSize: FontSize.s14,
        color: Colors.black,
        textBaseline: TextBaseline.alphabetic,
        inherit: false,
      );

  static TextStyle get trainerValues => TextStyle(
        fontFamily: FontFamily.light,
        fontSize: FontSize.s14,
        color: Colors.grey,
        textBaseline: TextBaseline.alphabetic,
        inherit: false,
      );

  static TextStyle get name => TextStyle(
        fontFamily: FontFamily.bold,
        fontSize: FontSize.s18,
        color: Colors.black,
        textBaseline: TextBaseline.alphabetic,
        inherit: false,
      );

  static TextStyle get loaderText => TextStyle(
        fontFamily: FontFamily.bold,
        fontSize: FontSize.s25,
        letterSpacing: 5,
        color: AppColors.primary,
        textBaseline: TextBaseline.alphabetic,
        inherit: false,
      );

  static TextStyle get warmGreyText => TextStyle(
        fontFamily: FontFamily.regular,
        fontSize: FontSize.s15,
        letterSpacing: 1,
        color: AppColors.warmGrey,
        textBaseline: TextBaseline.alphabetic,
        inherit: false,
      );

  static TextStyle get versionName => TextStyle(
        fontSize: FontSize.s10,
        color: Colors.grey.shade600,
        fontFamily: FontFamily.regular,
        letterSpacing: 3,
        textBaseline: TextBaseline.alphabetic,
        inherit: false,
      );

  static TextStyle get messageTime => TextStyle(
        fontSize: FontSize.s8,
        color: Colors.black,
        fontFamily: FontFamily.regular,
        letterSpacing: 1,
        textBaseline: TextBaseline.alphabetic,
        inherit: false,
      );

  static TextStyle get messageName => TextStyle(
        fontSize: FontSize.s10,
        color: Colors.black,
        fontFamily: FontFamily.bold,
        letterSpacing: 1,
        textBaseline: TextBaseline.alphabetic,
        inherit: false,
      );

  static TextStyle get aboutTitle => TextStyle(
        fontSize: FontSize.s15,
        color: AppColors.charcoalGrey,
        fontFamily: FontFamily.regular,
        letterSpacing: 0.33,
        textBaseline: TextBaseline.alphabetic,
        inherit: false,
      );

  static TextStyle get userName => TextStyle(
        fontSize: FontSize.s20,
        fontFamily: FontFamily.bold,
        color: Color(0xFF484751),
        letterSpacing: 0.38,
        textBaseline: TextBaseline.alphabetic,
        inherit: false,
      );

  static TextStyle get userPhone => TextStyle(
        fontFamily: FontFamily.regular,
        fontSize: FontSize.s15,
        letterSpacing: 0.33,
        color: Color(0xFF909090),
        textBaseline: TextBaseline.alphabetic,
        inherit: false,
      );

  static TextStyle get messageText => TextStyle(
        fontFamily: FontFamily.regular,
        fontSize: FontSize.s15,
        letterSpacing: 0.68,
        color: AppColors.white,
        textBaseline: TextBaseline.alphabetic,
        inherit: false,
      );

  static TextStyle get appBarText => TextStyle(
        fontFamily: FontFamily.regular,
        fontSize: FontSize.s16,
        letterSpacing: 0.68,
        color: AppColors.white,
        textBaseline: TextBaseline.alphabetic,
        inherit: false,
      );

  static TextStyle get webinarLink => TextStyle(
        fontFamily: FontFamily.regular,
        fontSize: FontSize.s16,
        letterSpacing: 0.68,
        color: AppColors.primary,
        textBaseline: TextBaseline.alphabetic,
        inherit: false,
      );

  static TextStyle get commentText => TextStyle(
        fontFamily: FontFamily.regular,
        fontSize: FontSize.s12,
        letterSpacing: 0.68,
        color: AppColors.grey,
        textBaseline: TextBaseline.alphabetic,
        inherit: false,
      );

  static TextStyle get uploadText => TextStyle(
        fontFamily: FontFamily.bold,
        fontSize: FontSize.s16,
        letterSpacing: 0.68,
        color: AppColors.greyish,
        textBaseline: TextBaseline.alphabetic,
        inherit: false,
      );

  static TextStyle get defaultRegular => TextStyle(
        fontFamily: FontFamily.regular,
        fontSize: FontSize.s15,
        color: Colors.black,
        textBaseline: TextBaseline.alphabetic,
        inherit: false,
      );

  static TextStyle get defaultBold => TextStyle(
        fontFamily: FontFamily.bold,
        fontSize: FontSize.s15,
        color: Colors.black,
        textBaseline: TextBaseline.alphabetic,
        inherit: false,
      );

  static TextStyle get defaultLight => TextStyle(
        fontFamily: FontFamily.light,
        fontSize: FontSize.s15,
        color: Colors.black,
        letterSpacing: 0.58,
        textBaseline: TextBaseline.alphabetic,
        inherit: false,
      );

  static TextStyle get hintText => TextStyle(
        fontFamily: FontFamily.light,
        fontSize: FontSize.s12,
        color: Colors.black,
        letterSpacing: 0.58,
        textBaseline: TextBaseline.alphabetic,
        inherit: false,
      );
}
