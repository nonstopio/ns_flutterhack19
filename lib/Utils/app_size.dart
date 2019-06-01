import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

double defaultScreenWidth = 400.0;
double defaultScreenHeight = 810.0;
double screenWidth = defaultScreenWidth;
double screenHeight = defaultScreenHeight;

class Sizes {
  /*Padding & Margin Constants*/
  static double s1 = 1.0;

  static double s2 = 2.0;
  static double s3 = 3.0;
  static double s4 = 4.0;
  static double s5 = 5.0;
  static double s8 = 8.0;
  static double s10 = 10.0;
  static double s12 = 12.0;
  static double s14 = 14.0;

  static double s15 = 15.0;
  static double s20 = 20.0;
  static double s22 = 22.0;
  static double s24 = 24.0;
  static double s25 = 25.0;
  static double s30 = 30.0;
  static double s35 = 35.0;

  static double s40 = 40.0;
  static double s45 = 45.0;

  static double s50 = 50.0;
  static double s60 = 60.0;
  static double s80 = 80.0;
  static double s100 = 100.0;
  static double s120 = 120.0;

  static double s150 = 150.0;
  static double s175 = 175.0;

  static double s200 = 200.0;
  static double s400 = 400.0;

  /*Screen Size dependent Constants*/
  static double screenWidthHalf = screenWidth / 2;
  static double screenWidthThird = screenWidth / 3;
  static double screenWidthFourth = screenWidth / 4;
  static double screenWidthFifth = screenWidth / 5;
  static double screenWidthSixth = screenWidth / 6;
  static double screenWidthTenth = screenWidth / 10;

  /*Image Dimensions*/

  static double defaultIconSize = 80.0;
  static double defaultImageHeight = 100.0;
  static double defaultCardHeight = 120.0;
  static double defaultImageRadius = 40.0;
  static double snackBarHeight = 50.0;
  static double texIconSize = 30.0;

  /*Default Height&Width*/
  static double defaultIndicatorHeight = 5.0;
  static double alertHeight = 200.0;
  static double appBarHeight = 220.0;
  static double minWidthAlertButton = 70.0;
  static double defaultIndicatorWidth = screenWidthFourth;

  /*EdgeInsets*/
  static EdgeInsets p8 = EdgeInsets.all(s8);
  static EdgeInsets p10 = EdgeInsets.all(s10);

  static void setScreenAwareConstant(context) {
    ScreenUtil.instance = ScreenUtil(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);

    Size size = MediaQuery.of(context).size;

    screenWidth = size.width;
    screenHeight = size.height;

    FontSize.setScreenAwareFontSize();

    /*Padding & Margin Constants*/

    s2 = ScreenUtil.instance.setWidth(2.0);
    s3 = ScreenUtil.instance.setWidth(3.0);
    s4 = ScreenUtil.instance.setWidth(4.0);
    s5 = ScreenUtil.instance.setWidth(5.0);
    s8 = ScreenUtil.instance.setWidth(8.0);
    s10 = ScreenUtil.instance.setWidth(10.0);
    s12 = ScreenUtil.instance.setWidth(12.0);
    s15 = ScreenUtil.instance.setWidth(15.0);
    s20 = ScreenUtil.instance.setWidth(20.0);
    s25 = ScreenUtil.instance.setWidth(25.0);
    s30 = ScreenUtil.instance.setWidth(30.0);
    s40 = ScreenUtil.instance.setWidth(40.0);
    s50 = ScreenUtil.instance.setWidth(50.0);
    s60 = ScreenUtil.instance.setWidth(60.0);
    s80 = ScreenUtil.instance.setWidth(80.0);
    s100 = ScreenUtil.instance.setWidth(100.0);
    s150 = ScreenUtil.instance.setWidth(150.0);
    s200 = ScreenUtil.instance.setWidth(200.0);
    s400 = ScreenUtil.instance.setWidth(400.0);

    /*EdgeInsets*/

    p8 = EdgeInsets.all(s8);
    p10 = EdgeInsets.all(s10);

    /*Screen Size dependent Constants*/
    screenWidthHalf = screenWidth / 2;
    screenWidthThird = screenWidth / 3;
    screenWidthFourth = screenWidth / 4;
    screenWidthFifth = screenWidth / 5;
    screenWidthSixth = screenWidth / 6;
    screenWidthTenth = screenWidth / 10;

    /*Image Dimensions*/

    defaultIconSize = ScreenUtil.instance.setWidth(80.0);
    defaultImageHeight = ScreenUtil.instance.setWidth(100.0);
    defaultCardHeight = ScreenUtil.instance.setWidth(120.0);
    defaultImageRadius = ScreenUtil.instance.setWidth(40.0);
    snackBarHeight = ScreenUtil.instance.setWidth(50.0);
    texIconSize = ScreenUtil.instance.setWidth(30.0);
    appBarHeight = ScreenUtil.instance.setWidth(220.0);

    /*Default Height&Width*/
    defaultIndicatorHeight = ScreenUtil.instance.setHeight(5.0);
    alertHeight = ScreenUtil.instance.setWidth(200.0);
    minWidthAlertButton = ScreenUtil.instance.setWidth(70.0);
    defaultIndicatorWidth = screenWidthFourth;
  }
}

class FontSize {
  static double s7 = 7.0;
  static double s8 = 8.0;
  static double s9 = 9.0;
  static double s10 = 10.0;
  static double s11 = 11.0;
  static double s12 = 12.0;
  static double s13 = 13.0;
  static double s14 = 14.0;
  static double s15 = 15.0;
  static double s16 = 16.0;
  static double s17 = 17.0;
  static double s18 = 18.0;
  static double s19 = 19.0;
  static double s20 = 20.0;
  static double s21 = 21.0;
  static double s22 = 22.0;
  static double s23 = 23.0;
  static double s24 = 24.0;
  static double s25 = 25.0;
  static double s26 = 26.0;
  static double s27 = 27.0;
  static double s28 = 28.0;
  static double s29 = 29.0;
  static double s30 = 30.0;
  static double s36 = 36.0;

  static setDefaultFontSize() {
    s7 = 7.0;
    s8 = 8.0;
    s9 = 9.0;
    s10 = 10.0;
    s11 = 11.0;
    s12 = 12.0;
    s13 = 13.0;
    s14 = 14.0;
    s15 = 15.0;
    s16 = 16.0;
    s17 = 17.0;
    s18 = 18.0;
    s19 = 19.0;
    s20 = 20.0;
    s21 = 21.0;
    s22 = 22.0;
    s23 = 23.0;
    s24 = 24.0;
    s25 = 25.0;
    s26 = 26.0;
    s27 = 27.0;
    s28 = 28.0;
    s29 = 29.0;
    s30 = 30.0;
    s36 = 36.0;
  }

  static setScreenAwareFontSize() {
    s7 = ScreenUtil.instance.setSp(7.0);
    s8 = ScreenUtil.instance.setSp(8.0);
    s9 = ScreenUtil.instance.setSp(9.0);
    s10 = ScreenUtil.instance.setSp(10.0);
    s11 = ScreenUtil.instance.setSp(11.0);
    s12 = ScreenUtil.instance.setSp(12.0);
    s13 = ScreenUtil.instance.setSp(13.0);
    s14 = ScreenUtil.instance.setSp(14.0);
    s15 = ScreenUtil.instance.setSp(15.0);
    s16 = ScreenUtil.instance.setSp(16.0);
    s17 = ScreenUtil.instance.setSp(17.0);
    s18 = ScreenUtil.instance.setSp(18.0);
    s19 = ScreenUtil.instance.setSp(19.0);
    s20 = ScreenUtil.instance.setSp(20.0);
    s21 = ScreenUtil.instance.setSp(21.0);
    s22 = ScreenUtil.instance.setSp(22.0);
    s23 = ScreenUtil.instance.setSp(23.0);
    s24 = ScreenUtil.instance.setSp(24.0);
    s25 = ScreenUtil.instance.setSp(25.0);
    s26 = ScreenUtil.instance.setSp(26.0);
    s27 = ScreenUtil.instance.setSp(27.0);
    s28 = ScreenUtil.instance.setSp(28.0);
    s29 = ScreenUtil.instance.setSp(29.0);
    s30 = ScreenUtil.instance.setSp(30.0);
    s36 = ScreenUtil.instance.setSp(36.0);
  }
}
