import 'package:flutter/material.dart';

import '../../../utils/app_config.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget(
      {super.key,
      this.height,
      this.width,
      required this.title,
      this.fontSize,
      required this.onTap,
      this.borderRadius = 20,
      this.backgroundColor = AppConfig.primaryBackgroundColorRed,
      this.fontColor = AppConfig.primaryWhite,
      this.border,
      this.margin});

  final double? height;
  final double? width;

  final String title;
  final double? fontSize;
  final Function() onTap;

  final double borderRadius;

  final Color? backgroundColor;
  final Color? fontColor;
  final Border? border;

  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin,
        height: height,
        width: width,
        decoration: BoxDecoration(
          border: border,
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                fontSize: fontSize,
                color: fontColor,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
