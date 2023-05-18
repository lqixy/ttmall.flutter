import 'package:flutter/material.dart';
import 'package:ttmall/shared/dependencies.dart';
import 'package:ttmall/utils/app_config.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget(this.msg, {super.key});
  final String msg;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        msg,
        style: AppTextStyle.appTextStyle(
            color: AppConfig.primaryBackgroundColorRed, size: 20.sp),
      ),
    );
  }
}
