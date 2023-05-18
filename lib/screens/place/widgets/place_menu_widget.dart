import 'package:flutter/material.dart';

import '../../../models/recommend/recommend_model.dart';
import '../../../shared/custom_cached_network_image_widget.dart';

/// 分类推荐
class PlaceMenuWidget extends StatelessWidget {
  const PlaceMenuWidget(
    this.list, {
    super.key,
  });

  // final int itemCount;

  final List<RecommendItemModel>? list;
  @override
  Widget build(BuildContext context) {
    if (list == null || list!.isEmpty) {
      return const SizedBox.shrink();
    } else {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.22,
        width: MediaQuery.of(context).size.width,
        child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: list!.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: (list!.length / 2).ceil()),
            itemBuilder: (context, index) {
              var curCategory = list![index];
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomCachedNetworkImageWidget(
                          imageUrl: curCategory.pic!,
                        ),
                      )),
                  Expanded(
                      flex: 1,
                      child: Text(
                        curCategory.title!,
                      )),
                ],
              );
            }),
      );
    }
  }
}
