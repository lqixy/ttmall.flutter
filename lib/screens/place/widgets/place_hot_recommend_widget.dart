import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ttmall/screens/place/widgets/place_item_title_widget.dart';

import '../../../models/recommend/recommend_model.dart';
import '../../../shared/product_card_widget.dart';
import '../../../utils/app_config.dart';

class PlaceHotRecommendWidget extends StatelessWidget {
  const PlaceHotRecommendWidget(
    this.list, {
    super.key,
  });

  final List<RecommendItemModel>? list;

  @override
  Widget build(BuildContext context) {
    if (list == null || list!.isEmpty) {
      return const SizedBox.shrink();
    } else {
      return Column(
        children: [
          PlaceItemTitleWidget(
            '热门推荐',
            backgroundColor: AppConfig.primaryBackgroundColorGrey,
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: list!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.6,

              // crossAxisSpacing: 2.0,
              crossAxisCount: 2,
            ),
            itemBuilder: (BuildContext context, int index) {
              var curProduct = list![index];
              return Stack(
                children: [
                  ProductCardWidget(
                    curProduct,
                    isVisible: true,
                  ),
                  Positioned(
                      top: 0,
                      right: 0,
                      child: Visibility(
                        visible: curProduct.stock! <= 0,
                        child: Image(
                          width: 30.w,
                          height: 30.h,
                          image: const AssetImage(
                            'assets/images/sell_out.png',
                          ),
                        ),
                      ))
                ],
              );
            },
          ),
        ],
      );
    }
  }
}
