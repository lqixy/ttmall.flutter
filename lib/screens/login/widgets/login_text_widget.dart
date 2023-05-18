import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/app_config.dart';

class LoginTextWidget extends StatelessWidget {
  LoginTextWidget(
      {super.key, required this.content, required this.onTap, this.fontColor});

  String content;
  Color? fontColor;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        content,
        style: TextStyle(
            fontSize: 16.sp,
            color: fontColor ?? AppConfig.secondTextColorGery,
            fontWeight: FontWeight.w400),
      ),
    );
  }
}
