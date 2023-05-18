// import 'package:ttmall/shared/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../models/products/product_info_model.dart';
import '../../../utils/app_config.dart';

class ProductPriceWidget extends StatelessWidget {
  const ProductPriceWidget(
    this.model, {
    super.key,
  });

  final Goodsstandard model;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ProductPriceItemWidget(
            model: model,
            leadingSize: 18.sp,
            endSize: 28.sp,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Column(
            children: [
              Icon(
                Icons.favorite_border,
                color: AppConfig.secondColorGrey,
              ),
              Text(
                '加关注',
                style: AppTextStyle.appTextStyle(
                    color: AppConfig.secondColorGrey, size: 12),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class ProductPriceItemWidget extends StatelessWidget {
  ProductPriceItemWidget({
    super.key,
    required this.model,
    required this.leadingSize,
    required this.endSize,
  });

  final Goodsstandard? model;
  double leadingSize;
  double endSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '¥',
          style: AppTextStyle.appTextStyle(
              color: AppConfig.primaryBackgroundColorRed,
              size: leadingSize,
              fw: FontWeight.w500),
        ),
        Text(
          '${model?.price?.split('.')[0]}',
          style: AppTextStyle.appTextStyle(
              color: AppConfig.primaryBackgroundColorRed,
              size: endSize,
              fw: FontWeight.w500),
        ),
        Text(
          '.',
          style: AppTextStyle.appTextStyle(
              color: AppConfig.primaryBackgroundColorRed,
              size: endSize,
              fw: FontWeight.w400),
        ),
        Text(
          '${model?.price?.split('.')[1]}',
          style: AppTextStyle.appTextStyle(
              color: AppConfig.primaryBackgroundColorRed,
              size: leadingSize,
              fw: FontWeight.w400),
        ),
      ],
    );
  }
}
