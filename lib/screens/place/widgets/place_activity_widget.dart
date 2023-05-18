import 'package:flutter/material.dart';
import 'package:ttmall/bloc/place/place_bloc.dart';
import 'package:ttmall/screens/place/widgets/place_item_title_widget.dart';
import 'package:ttmall/shared/dependencies.dart';
import 'package:ttmall/utils/app_extensions.dart';

import '../../../models/recommend/recommend_model.dart';
import '../../../shared/custom_cached_network_image_widget.dart';

class PlaceActivityWidget extends StatelessWidget {
  const PlaceActivityWidget(
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
        height: MediaQuery.of(context).size.height * 0.25,
        child: Column(
          children: [
            const Expanded(flex: 1, child: PlaceItemTitleWidget('活动专区')),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                    onTap: () {
                      if (list![0].link!.contains('topic')) {
                        var topicCode = list![0].link.getContent('=');
                        BlocProvider.of<PlaceBloc>(context)
                            .add(PlaceJumpToEvent(context, topicCode));
                      }
                    },
                    child: CustomCachedNetworkImageWidget(
                        imageUrl: list![0].pic!)),
              ),
            )
          ],
        ),
      );
    }
  }
}
