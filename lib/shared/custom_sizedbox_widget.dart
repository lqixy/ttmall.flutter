import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ttmall/utils/app_config.dart';

class Custom10SizedboxWidget extends StatelessWidget {
  const Custom10SizedboxWidget({super.key});
  // double? height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10.h,
      child: Container(
        color: AppConfig.primaryBackgroundColorGrey,
      ),
    );
  }
}

class Custom5SizedboxWidget extends StatelessWidget {
  const Custom5SizedboxWidget({super.key});
  // double? height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 5.h,
      child: Container(
        color: AppConfig.primaryBackgroundColorGrey,
      ),
    );
  }
}
