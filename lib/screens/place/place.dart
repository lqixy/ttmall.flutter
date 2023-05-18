import 'package:ttmall/screens/place/widgets/place_activity_widget.dart';
import 'package:ttmall/screens/place/widgets/place_best_widget.dart';
import 'package:ttmall/screens/place/widgets/place_brand_widget.dart';
import 'package:ttmall/screens/place/widgets/place_hot_recommend_widget.dart';
import 'package:ttmall/screens/place/widgets/place_large_recommend_widget.dart';
import 'package:ttmall/screens/place/widgets/place_menu_widget.dart';
import 'package:ttmall/shared/custom_cached_network_image_widget.dart';
import 'package:ttmall/shared/custom_error_widget.dart';
import 'package:ttmall/shared/custom_loading_circle_widget.dart';
import 'package:ttmall/shared/custom_more_popup_button_widget.dart';
import 'package:ttmall/shared/custom_sizedbox_widget.dart';
import 'package:ttmall/shared/custom_slider_widget.dart';

import 'package:ttmall/utils/app_config.dart';

import '../../bloc/place/place_bloc.dart';
import '../../shared/dependencies.dart';

class PlaceScreen extends StatelessWidget {
  const PlaceScreen({super.key, this.placeName = ''});

  final String placeName;
  @override
  Widget build(BuildContext context) {
    context.read<PlaceBloc>().add(PlaceLoadEvent(placeName));
    return Scaffold(
      backgroundColor: AppConfig.primaryWhite,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppConfig.secondColorGrey),
        backgroundColor: AppConfig.primaryWhite,
        elevation: 0,
        title: Text(
          placeName,
          style: AppTextStyle.appTextStyle(
            color: AppConfig.primaryTextColorBlack,
            size: 18,
          ),
        ),
        actions: [CustomMorePopupButtonWidget(pageIndex: 1)],
      ),
      body: BlocBuilder<PlaceBloc, PlaceState>(
        builder: (context, state) {
          if (state is PlaceLoadedState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  CustomSliderWidget(
                    state.model.slider.list!
                        .map((e) =>
                            CustomCachedNetworkImageWidget(imageUrl: e.pic!))
                        .toList(),
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width,
                  ),
                  PlaceMenuWidget(state.model.category.list),
                  PlaceBestWidget(state.model.miaosha.list),
                  const Custom10SizedboxWidget(),
                  PlaceActivityWidget(state.model.activity.list),
                  const Custom10SizedboxWidget(),
                  PlaceBrandWidget(state.model.brand),
                  const Custom10SizedboxWidget(),
                  PlaceLargeRecommendWidget(
                      state.model.bigimage.list, state.model.product.list),
                  PlaceLargeRecommendWidget(
                      state.model.bigimage2.list, state.model.product2.list),
                  PlaceLargeRecommendWidget(
                      state.model.bigimage3.list, state.model.product3.list),
                  PlaceLargeRecommendWidget(
                      state.model.bigimage4.list, state.model.product4.list),
                  PlaceHotRecommendWidget(state.model.hotrecommend.list),
                ],
              ),
            );
          } else if (state is PlaceErrorState) {
            return CustomErrorWidget(state.msg);
          } else {
            return const CustomLoadingCircleWidget();
          }
        },
      ),
    );
  }
}
