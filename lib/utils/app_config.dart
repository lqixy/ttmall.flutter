import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppConfig {
  static const Color primaryWhite = Color(0xffffffff);
  static Color primaryBackgroundColorGrey = Colors.grey[50]!;
  static const Color secondBackgroundColorGrey = Color(0xff777777);
  static const Color secondColorGrey = Colors.grey;
  static const Color primaryTextColorBlack = Colors.black;
  static Color secondTextColorGery = Colors.grey[800]!;
  static const Color primaryBackgroundColorRed = Color(0xffe32525);
  static Color primaryColorYellow = const Color(0xffffc107);
  static const Color secondColorYellow = Color(0xfffac450);
  static Color primaryColorPink = const Color.fromRGBO(242, 48, 48, 0.2);
  static Color primaryColorLightPink = const Color(0xffff7a70);
  static Color secondBlack = const Color(0xff3f4446);
  static const Color primaryColorBlue = Color(0xffd8e7ff);
  static const Color toastColorBlack = Color(0xff4e4e4e);
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

void customShowSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      content: Container(
        alignment: Alignment.center,
        child: Text(
          content,
          style: AppTextStyle.appTextStyle(
              size: 10.sp, color: AppConfig.primaryWhite),
        ),
      )));
}
