import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/app_config.dart';

class CustomTextFieldWidget extends StatelessWidget {
  const CustomTextFieldWidget(this.hintText, this.iconData, this.controller,
      {super.key,
      this.obscureText = false,
      this.textInputType,
      this.suffixIcon});

  final IconData iconData;
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final TextInputType? textInputType;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: TextFormField(
        keyboardType: textInputType,
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          // border: OutlineInputBorder(),
          prefixIcon: Icon(
            iconData,
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: AppConfig.secondTextColorGery),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
