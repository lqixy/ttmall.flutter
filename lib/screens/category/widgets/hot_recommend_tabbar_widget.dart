import 'package:ttmall/shared/dependencies.dart';

import '../../../models/category/hot_recommend_model.dart';
import '../../../shared/custom_cached_network_image_widget.dart';
import '../../../utils/app_config.dart';

class HotRecommendTabbarWidget extends StatelessWidget {
  const HotRecommendTabbarWidget(this.onTap, this.selectedIndex, {super.key});

  final Function() onTap;
  final int selectedIndex;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // color: Colors.orange,
        padding: EdgeInsets.all(8.sp),
        child: SizedBox(
          height: 40.h,
          width: 40.w,
          child: Text(
            '热门推荐',
            style: TextStyle(
                color: selectedIndex == -1
                    ? AppConfig.primaryBackgroundColorRed
                    : AppConfig.primaryTextColorBlack),
          ),
        ),
      ),
    );
  }
}

class HotRecommendTabViewWidget extends StatelessWidget {
  const HotRecommendTabViewWidget(
    this.selectedIndex,
    this.list, {
    super.key,
  });

  final int selectedIndex;
  final List<HotRecommendItemModel> list;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: selectedIndex == -1,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width * 0.7,
        child: GridView.builder(
          itemCount: list.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemBuilder: (context, index) {
            var curHot = list[index];
            return Container(
              padding: EdgeInsets.all(6.sp),
              child: Column(
                children: [
                  CustomCachedNetworkImageWidget(imageUrl: curHot.iconurl!),
                  Container(
                    padding: EdgeInsets.only(top: 8.sp),
                    child: Text(
                      curHot.title!,
                      style: AppTextStyle.appTextStyle(
                          color: AppConfig.secondTextColorGery, size: 12.sp),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
