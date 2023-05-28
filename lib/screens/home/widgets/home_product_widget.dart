import 'package:ttmall/bloc/navigator/navigator_bloc.dart';
import 'package:ttmall/screens/topic/topic.dart';
import 'package:ttmall/shared/custom_error_widget.dart';
import 'package:ttmall/shared/dependencies.dart';

import 'package:ttmall/shared/custom_cached_network_image_widget.dart';

import 'package:ttmall/shared/custom_sizedbox_widget.dart';

import 'package:ttmall/utils/app_config.dart';
import 'package:ttmall/utils/app_extensions.dart';

import '../../../bloc/home/home_bloc.dart';
import '../../../models/recommend/recommend_model.dart';
import '../../../shared/custom_loading_circle_widget.dart';
import '../../../shared/product_card_widget.dart';

class HomeProductWidget extends StatelessWidget {
  const HomeProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // print('home build;');
    final homeBloc = context.read<HomeBloc>();
    homeBloc.add(HomeLoadEvent());
    return Container(
      color: AppConfig.primaryWhite,
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoadedState) {
            return Column(
              children: state.recommends
                  .map((e) => HomeProductItemWidget(
                        e.list,
                      ))
                  .toList(),
            );
          } else if (state is HomeErrorState) {
            return CustomErrorWidget(state.msg);
          } else {
            return const CustomLoadingCircleWidget();
          }
        },
      ),
    );
  }
}

class HomeProductItemWidget extends StatelessWidget {
  const HomeProductItemWidget(this.items, {super.key});

  final List<RecommendItemModel>? items;

  @override
  Widget build(BuildContext context) {
    if (items == null || items!.isEmpty) {
      return const SizedBox.shrink();
    } else {
      return Column(
        children: [
          GestureDetector(
            onTap: () {
              var topicCode = items![0].link.getContent('=');
              BlocProvider.of<NavigatorBloc>(context).add(NavigatorPushEvent(
                context,
                TopicScreen(topicCode),
              ));
            },
            child: CustomCachedNetworkImageWidget(
                height: MediaQuery.of(context).size.height * 0.33,
                imageUrl: items![0].pic!),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Row(
                  // children: List.generate(5, (index) => ProductCardWidget()),
                  children: items!
                      .where((element) => element.args!.isNotEmpty)
                      .map((e) => ProductCardWidget(
                            e,
                            height: MediaQuery.of(context).size.height * 0.33,
                            width: MediaQuery.of(context).size.width * 0.4,
                          ))
                      .toList(),
                ),
                const Custom10SizedboxWidget(),
                Container(
                  height: 200.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: AppConfig.primaryBackgroundColorGrey,
                          width: 1)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        '查看更多',
                        style: TextStyle(
                            color: AppConfig.primaryBackgroundColorRed),
                      ),
                      Icon(
                        Icons.more_horiz,
                        size: 40.sp,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 10.h,
            color: AppConfig.primaryBackgroundColorGrey,
          ),
        ],
      );
    }
  }
}
