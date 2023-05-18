import 'package:ttmall/bloc/products/product_bloc.dart';
import 'package:ttmall/bloc/topic/topic_bloc.dart';
import 'package:ttmall/models/recommend/recommend_model.dart';
import 'package:ttmall/shared/custom_button_widget.dart';
import 'package:ttmall/shared/custom_cached_network_image_widget.dart';
import 'package:ttmall/shared/custom_error_widget.dart';
import 'package:ttmall/shared/custom_loading_circle_widget.dart';
import 'package:ttmall/shared/custom_more_popup_button_widget.dart';
import 'package:ttmall/shared/dependencies.dart';
import 'package:ttmall/shared/product_card_widget.dart';
import 'package:ttmall/utils/app_config.dart';

import '../../models/topic/topic_model.dart';

class TopicScreen extends StatelessWidget {
  const TopicScreen(this.topicCode, {super.key});

  final String topicCode;

  @override
  Widget build(BuildContext context) {
    context.read<TopicBloc>().add(TopicLoadEvent(topicCode));
    return BlocBuilder<TopicBloc, TopicState>(
      builder: (context, state) {
        if (state is TopicLoadedState) {
          var largeTags = state.model.topictag!
              .where((element) =>
                  element.productlist != null &&
                  element.productlist!.length == 1)
              .toList();
          var recommendTags = state.model.topictag!
              .where((element) =>
                  element.productlist != null &&
                  element.productlist!.length > 1)
              .toList();
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppConfig.primaryWhite,
              elevation: 0.0,
              title: Text(
                state.model.topicTitle!,
                style: AppTextStyle.appTextStyle(
                    color: AppConfig.primaryTextColorBlack),
              ),
              centerTitle: true,
              foregroundColor: AppConfig.secondColorGrey,
              actions: [CustomMorePopupButtonWidget(pageIndex: -1)],
            ),
            backgroundColor: AppConfig.primaryColorBlue,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width,
                    child: CustomCachedNetworkImageWidget(
                      imageUrl: state.model.posterimg!,
                      fit: BoxFit.fill,
                    ),
                  ),
                  // Visibility(
                  //   visible: largeTags.isEmpty,
                  //   child: Container(
                  //     height: MediaQuery.of(context).size.height * 0.08,
                  //     width: MediaQuery.of(context).size.width,
                  //     color: AppConfig.primaryWhite,
                  //     child: SingleChildScrollView(
                  //       scrollDirection: Axis.horizontal,
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.start,
                  //         children: recommendTags
                  //             .map((e) => Container(
                  //                 alignment: Alignment.center,
                  //                 margin: EdgeInsets.symmetric(horizontal: 8.0),
                  //                 padding: EdgeInsets.symmetric(horizontal: 8),
                  //                 child: Text(
                  //                   e.tagname!,
                  //                   style: AppTextStyle.appTextStyle(
                  //                     size: 16.sp,
                  //                   ),
                  //                 )))
                  //             .toList(),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  TopicLargeImageWidget(largeTags),
                  TopicRecommendWidget(recommendTags),
                ],
              ),
            ),
          );
        } else if (state is TopicErrorState) {
          return Scaffold(
            backgroundColor: AppConfig.primaryWhite,
            body: CustomErrorWidget(state.msg),
          );
        } else {
          return const Scaffold(
            backgroundColor: AppConfig.primaryWhite,
            body: CustomLoadingCircleWidget(),
          );
        }
      },
    );
  }
}

class TopicLargeImageWidget extends StatelessWidget {
  const TopicLargeImageWidget(
    this.tags, {
    super.key,
  });
  final List<Topictag> tags;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: tags
          .map((e) => GestureDetector(
              onTap: () {
                BlocProvider.of<ProductBloc>(context).add(
                    ProductJumpToDetailEvent(
                        context, e.productlist!.first.goodsid!));
              },
              child: CustomCachedNetworkImageWidget(imageUrl: e.tagimg!)))
          .toList(),
    );
  }
}

class TopicRecommendWidget extends StatelessWidget {
  const TopicRecommendWidget(this.tags, {super.key});
  final List<Topictag>? tags;
  // final ItemScrollController _itemScrollController;
  @override
  Widget build(BuildContext context) {
    if (tags == null || tags!.isEmpty) {
      return const SizedBox.shrink();
    } else {
      // var tag = tags!.last;
      return Column(
        children: tags!
            .map((tag) => Column(
                  children: [
                    CustomCachedNetworkImageWidget(imageUrl: tag.tagimg!),
                    GridView.builder(
                        itemCount: tag.productlist!.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent:
                                MediaQuery.of(context).size.height * 0.25,
                            crossAxisCount: 3),
                        itemBuilder: (context, index) {
                          var curProduct = tag.productlist![index];
                          return Container(
                            color: AppConfig.primaryWhite,
                            // width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.all(2.0),
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 6,
                                  child: Stack(children: [
                                    ProductCardWidget(
                                      RecommendItemModel(
                                          goodsid: curProduct.goodsid,
                                          title: curProduct.goodsname,
                                          pic: curProduct.goodsurl,
                                          sellprice: curProduct.sellprice,
                                          stock: curProduct.stock),
                                      margin: const EdgeInsets.all(1.0),
                                      nameSize: 10.sp,
                                      nameFw: FontWeight.normal,
                                      priceSize: 10.sp,
                                    ),
                                    Visibility(
                                      visible: curProduct.stock! <= 0,
                                      child: Positioned(
                                          top: 0,
                                          right: 0,
                                          left: 0,
                                          bottom: 0,
                                          child: GestureDetector(
                                              onTap: () {
                                                BlocProvider.of<ProductBloc>(
                                                        context)
                                                    .add(
                                                        ProductJumpToDetailEvent(
                                                            context,
                                                            curProduct
                                                                .goodsid!));
                                              },
                                              child:
                                                  const SellOutOpacityWidget())),
                                    ),
                                  ]),
                                ),
                                Expanded(
                                    flex: 1,
                                    child: CustomButtonWidget(
                                        backgroundColor: curProduct.stock != 0
                                            ? AppConfig
                                                .primaryBackgroundColorRed
                                            : AppConfig.secondColorGrey,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 4.0, vertical: 2.0),
                                        title: '加入购物车',
                                        fontSize: 10.sp,
                                        onTap: () {
                                          if (curProduct.stock! > 0) {
                                            print('add cart');
                                          }
                                        })),
                              ],
                            ),
                          );
                        })
                  ],
                ))
            .toList(),
      );
    }
  }
}

class TopicProductWidget extends StatelessWidget {
  const TopicProductWidget({
    super.key,
    required this.tag,
  });

  final Topictag tag;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomCachedNetworkImageWidget(imageUrl: tag.tagimg!),
        GridView.builder(
            itemCount: tag.productlist!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: MediaQuery.of(context).size.height * 0.25,
                crossAxisCount: 3),
            itemBuilder: (context, index) {
              var curProduct = tag.productlist![index];
              return Container(
                color: AppConfig.primaryWhite,
                // width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.all(2.0),
                child: Column(
                  children: [
                    Expanded(
                      flex: 6,
                      child: Stack(children: [
                        ProductCardWidget(
                          RecommendItemModel(
                              goodsid: curProduct.goodsid,
                              title: curProduct.goodsname,
                              pic: curProduct.goodsurl,
                              sellprice: curProduct.sellprice,
                              stock: curProduct.stock),
                          margin: const EdgeInsets.all(1.0),
                          nameSize: 10.sp,
                          nameFw: FontWeight.normal,
                          priceSize: 10.sp,
                        ),
                        Visibility(
                          visible: curProduct.stock! <= 0,
                          child: Positioned(
                              top: 0,
                              right: 0,
                              left: 0,
                              bottom: 0,
                              child: GestureDetector(
                                  onTap: () {
                                    BlocProvider.of<ProductBloc>(context).add(
                                        ProductJumpToDetailEvent(
                                            context, curProduct.goodsid!));
                                  },
                                  child: const SellOutOpacityWidget())),
                        ),
                      ]),
                    ),
                    Expanded(
                        flex: 1,
                        child: CustomButtonWidget(
                            backgroundColor: curProduct.stock != 0
                                ? AppConfig.primaryBackgroundColorRed
                                : AppConfig.secondColorGrey,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 4.0, vertical: 2.0),
                            title: '加入购物车',
                            fontSize: 10.sp,
                            onTap: () {
                              if (curProduct.stock! > 0) {
                                print('add cart');
                              }
                            })),
                  ],
                ),
              );
            })
      ],
    );
  }
}

class SellOutOpacityWidget extends StatelessWidget {
  const SellOutOpacityWidget({super.key, this.height, this.width});

  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.7,
      child: Container(
        height: height,
        width: width,
        color: AppConfig.secondColorGrey,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 14.0),
          alignment: Alignment.center,
          height: 60.h,
          width: 60.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 1.0, color: AppConfig.primaryWhite),
            // color: Colors.grey,
            // borderRadius: BorderRadius.circular(5.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Transform.rotate(
              angle: 0.6,
              child: Text(
                '售罄',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
