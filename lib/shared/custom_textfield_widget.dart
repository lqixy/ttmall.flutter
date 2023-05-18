import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/app_config.dart';

class CustomTextFieldWidget extends StatelessWidget {
  CustomTextFieldWidget(
      {super.key,
      required this.hintText,
      required this.iconData,
      this.obscureText = false});

  IconData iconData;
  String hintText;
  bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: TextFormField(
        obscureText: obscureText,
        decoration: InputDecoration(
            // border: OutlineInputBorder(),
            prefixIcon: Icon(
              iconData,
            ),
            hintText: hintText,
            hintStyle: TextStyle(color: AppConfig.secondTextColorGery)),
      ),
    );
  }
}
