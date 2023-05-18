import 'package:flutter/material.dart';
import 'package:ttmall/screens/place/widgets/place_item_title_widget.dart';
import 'package:ttmall/utils/app_extensions.dart';

import '../../../models/recommend/recommend_model.dart';
import '../../../shared/custom_cached_network_image_widget.dart';
import '../../../utils/app_config.dart';

class PlaceBrandWidget extends StatelessWidget {
  const PlaceBrandWidget(
    this.brand, {
    super.key,
  });

  final RecommendModel brand;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Column(
        children: [
          Expanded(
              flex: 1,
              child: PlaceItemTitleWidget(brand.placename.getContent('.'))),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                  itemCount: brand.list!.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 6,
                      crossAxisSpacing: 6,
                      crossAxisCount: 4),
                  itemBuilder: (context, index) {
                    var curBrand = brand.list![index];
                    return CustomCachedNetworkBorderImageWidget(
                      imageUrl: curBrand.pic!,
                      border: Border.all(
                          color: AppConfig.secondColorGrey, width: 0.5),
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }
}
