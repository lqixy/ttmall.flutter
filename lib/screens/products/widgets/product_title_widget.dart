import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../models/products/product_info_model.dart';
import '../../../utils/app_config.dart';

class ProductTitleWidget extends StatelessWidget {
  ProductTitleWidget({super.key, required this.model});

  Goodsstandard? model;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10.w, top: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Offstage(
            offstage: model?.stock != 0,
            child: Container(
              margin: EdgeInsets.only(left: 12.sp, right: 12.sp),
              decoration: BoxDecoration(
                  color: AppConfig.secondColorGrey,
                  borderRadius: BorderRadius.circular(2)),
              child: Center(
                child: Text(
                  '售罄',
                  style: AppTextStyle.appTextStyle(
                      color: AppConfig.primaryWhite,
                      size: 13.sp,
                      fw: FontWeight.w800,
                      letterSpacing: 2.sp),
                ),
              ),
            ),
          ),
          Expanded(
            child: Text(
              '${model?.goodsname}',
              maxLines: 2,
              // softWrap: false,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle.appTextStyle(
                  size: 14.sp, fw: FontWeight.bold, letterSpacing: 2.sp),
            ),
          ),
        ],
      ),
    );
  }
}
