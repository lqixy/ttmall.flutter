import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ttmall/screens/place/widgets/place_item_title_widget.dart';

import '../../../models/recommend/recommend_model.dart';
import '../../../shared/product_card_widget.dart';
import '../../../utils/app_config.dart';

class PlaceBestWidget extends StatelessWidget {
  const PlaceBestWidget(
    this.list, {
    super.key,
  });

  final List<RecommendItemModel>? list;
  @override
  Widget build(BuildContext context) {
    if (list == null || list!.isEmpty) {
      return const SizedBox.shrink();
    } else {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width,
        // color: AppConfig.primaryBackgroundColorGrey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: PlaceItemTitleWidget(
                  '口碑精选',
                  backgroundColor: AppConfig.primaryBackgroundColorGrey,
                )),
            Expanded(
              flex: 6,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: list!
                      .map(
                        (e) => ProductCardWidget(
                          e,
                          nameSize: 10.sp,
                          priceSize: 10.sp,
                          width: MediaQuery.of(context).size.width * 0.3,
                        ),
                      )
                      .toList(),
                ),
              ),
            )
          ],
        ),
      );
    }
  }
}
