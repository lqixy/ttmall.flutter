import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../models/products/receipt_service.dart';
import '../../../utils/app_config.dart';

class ProductReceiptServiceWidget extends StatelessWidget {
  ProductReceiptServiceWidget({super.key, required this.models, this.onTap});
  List<ServiceModel> models;
  Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      // width: 100.w,
      child: GestureDetector(
        onTap: onTap,
        child: Wrap(
          spacing: 4.w,
          direction: Axis.horizontal,
          alignment: WrapAlignment.start,
          children: models
              .map((e) => ProductReceiptServiceItemWidget(
                    content: e.title!,
                  ))
              .toList(),
        ),
      ),
    );
  }
}

class ProductReceiptServiceItemWidget extends StatelessWidget {
  ProductReceiptServiceItemWidget({super.key, required this.content});
  String content;
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(8),
      // width: 100.w,
      child: Wrap(
        spacing: 4.w,
        children: [
          Icon(
            Icons.check_circle_outline,
            color: AppConfig.secondColorGrey,
            size: 18.sp,
          ),
          Text(
            content,
            style: AppTextStyle.appTextStyle(
                color: AppConfig.secondColorGrey, size: 14.sp),
          ),
        ],
      ),
    );
  }
}
