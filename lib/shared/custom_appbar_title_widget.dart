import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_config.dart';

class CustomAppBarTitleWidget extends StatelessWidget {
  const CustomAppBarTitleWidget(this.title, {super.key});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyle.appTextStyle(
          color: AppConfig.primaryTextColorBlack, size: 14.sp),
    );
  }
}
