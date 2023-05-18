import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/app_config.dart';

class ProductDesWidget extends StatelessWidget {
  ProductDesWidget({super.key, required this.goodsdesc});
  String? goodsdesc;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(top: 12.h, bottom: 12.h),
        margin: EdgeInsets.only(left: 12.w),
        child: Text(
          goodsdesc!,
          style: AppTextStyle.appTextStyle(
              color: AppConfig.secondColorGrey,
              size: 12.sp,
              fw: FontWeight.w500),
          // textAlign: TextAlign.start,
        ));
  }
}
