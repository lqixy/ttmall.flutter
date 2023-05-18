import 'package:flutter/material.dart';

class AppConfig {
  static const Color primaryWhite = Color(0xffffffff);
  static Color primaryBackgroundColorGrey = Colors.grey[200]!;
  static Color secondColorGrey = Colors.grey;
  static const Color primaryTextColorBlack = Colors.black;
  static Color secondTextColorGery = Colors.grey[800]!;
  static const Color primaryBackgroundColorRed = Color(0xffe32525);
  static Color primaryColorYellow = const Color(0xffffc107);
  static Color primaryColorPink = const Color.fromRGBO(242, 48, 48, 0.2);
  static Color primaryColorLightPink = const Color(0xffff7a70);
  static Color secondBlack = const Color(0xff3f4446);
  static const Color primaryColorBlue = Color(0xffd8e7ff);
}

class AppTextStyle {
  static TextStyle appTextStyle(
      {Color? color = AppConfig.primaryTextColorBlack,
      double? size,
      FontWeight? fw = FontWeight.normal,
      double? letterSpacing,
      TextDecoration? textDecoration}) {
    return TextStyle(
        color: color,
        fontSize: size,
        fontWeight: fw,
        letterSpacing: letterSpacing,
        decoration: textDecoration);
  }
}
