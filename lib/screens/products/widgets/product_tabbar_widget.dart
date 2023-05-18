import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/app_config.dart';

class ProductTabBarWidget extends StatelessWidget {
  const ProductTabBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
        labelColor: AppConfig.primaryBackgroundColorRed,
        unselectedLabelColor: AppConfig.primaryTextColorBlack,
        indicatorColor: AppConfig.primaryBackgroundColorRed,
        indicatorSize: TabBarIndicatorSize.label,
        labelStyle: AppTextStyle.appTextStyle(size: 15.sp, fw: FontWeight.w400),
        tabs: const [
          Tab(
            text: '商品',
          ),
          Tab(
            text: '详情',
          ),
          Tab(
            text: '评价',
          ),
        ]);
  }
}
