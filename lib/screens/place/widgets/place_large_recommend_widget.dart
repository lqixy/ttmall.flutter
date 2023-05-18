import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../models/recommend/recommend_model.dart';
import '../../../shared/custom_cached_network_image_widget.dart';
import '../../../shared/custom_sizedbox_widget.dart';
import '../../../shared/product_card_widget.dart';

class PlaceLargeRecommendWidget extends StatelessWidget {
  const PlaceLargeRecommendWidget(
    this.largeImage,
    this.product, {
    super.key,
  });
  final List<RecommendItemModel>? largeImage;
  final List<RecommendItemModel>? product;
  @override
  Widget build(BuildContext context) {
    if (largeImage == null || largeImage!.isEmpty) {
      return const SizedBox.shrink();
    } else {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: CustomCachedNetworkImageWidget(
                imageUrl: largeImage!.first.pic!,
                width: MediaQuery.of(context).size.width,
                // fit: BoxFit.cover,
              ),
            ),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: product!
                      .map((e) => ProductCardWidget(
                            e,
                            width: MediaQuery.of(context).size.width * 0.3,
                            nameSize: 10.sp,
                          ))
                      .toList(),
                ),
              ),
            ),
            const Custom10SizedboxWidget(),
          ],
        ),
      );
    }
  }
}
