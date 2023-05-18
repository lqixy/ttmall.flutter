import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:ttmall/bloc/products/comments_bloc.dart';
import 'package:ttmall/bloc/products/product_bloc.dart';
import 'package:ttmall/models/products/prodetail_comment_model.dart';
import 'package:ttmall/models/products/prodetail_image_model.dart';

import 'package:ttmall/screens/products/widgets/product_info_tabview_widget.dart';
import 'package:ttmall/screens/products/widgets/product_tabbar_widget.dart';
import 'package:ttmall/shared/custom_loading_circle_widget.dart';
import 'package:ttmall/shared/dependencies.dart';
import 'package:ttmall/utils/app_config.dart';
import 'package:ttmall/utils/app_extensions.dart';
import '../../shared/custom_cached_network_image_widget.dart';

class ProductScreen extends StatelessWidget {
  final String goodsId;

  const ProductScreen(this.goodsId, {super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProductBloc>().add(ProductLoadEvent(goodsId));

    return DefaultTabController(
      length: 3,
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          var isVisibility = false;
          if (state is ProductLoadedState) {
            var curState = state;
            isVisibility = curState.model.goodsstandard!
                .any((element) => element.stock != 0);
          }

          return Scaffold(
            backgroundColor: AppConfig.primaryWhite,
            appBar: AppBar(
              title: const ProductTabBarWidget(),
              elevation: 0,
              backgroundColor: AppConfig.primaryWhite,
              iconTheme: IconThemeData(color: AppConfig.primaryTextColorBlack),
            ),
            body: ProductBodyWidget(state),
            bottomNavigationBar:
                ProductBottomWidget(isVisibility: isVisibility),
          );
        },
      ),
    );
  }
}

class ProductBottomWidget extends StatelessWidget {
  const ProductBottomWidget({
    super.key,
    this.isVisibility = true,
  });

  final bool isVisibility;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        decoration: BoxDecoration(
            border: Border(
          top:
              BorderSide(color: AppConfig.primaryBackgroundColorGrey, width: 1),
        )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 1,
              child: Icon(
                Icons.sms_outlined,
                size: 30.sp,
              ),
            ),
            Expanded(
              flex: 1,
              child: Icon(
                Icons.shopping_cart_outlined,
                size: 30.sp,
              ),
            ),
            Visibility(
              visible: isVisibility,
              maintainSize: false,
              child: Expanded(
                flex: 2,
                child: Container(
                    color: AppConfig.primaryBackgroundColorRed,
                    child: Center(
                        child: Text(
                      '立即购买',
                      style: AppTextStyle.appTextStyle(
                          color: AppConfig.primaryWhite, size: 16.sp),
                    ))),
              ),
            ),
            Visibility(
              visible: isVisibility,
              maintainSize: false,
              child: Expanded(
                flex: 2,
                child: Container(
                    color: AppConfig.primaryTextColorBlack,
                    child: Center(
                        child: Text(
                      '加入购物车',
                      style: AppTextStyle.appTextStyle(
                          color: AppConfig.primaryWhite, size: 16.sp),
                    ))),
              ),
            ),
            Visibility(
              visible: !isVisibility,
              maintainSize: false,
              child: Expanded(
                flex: 4,
                child: Container(
                    color: AppConfig.primaryColorYellow,
                    child: Center(
                        child: Text(
                      '到货提醒',
                      style: AppTextStyle.appTextStyle(
                          size: 16.sp, fw: FontWeight.bold),
                    ))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductBodyWidget extends StatelessWidget {
  const ProductBodyWidget(
    this.state, {
    super.key,
  });

  final ProductState state;
  @override
  Widget build(BuildContext context) {
    if (state is ProductLoadingState) {
      return const CustomLoadingCircleWidget();
    } else if (state is ProductLoadedState) {
      var curState = state as ProductLoadedState;

      return TabBarView(children: [
        ProductInfoTabViewWidget(
          curState,
        ),
        ProductDetailTabViewWidget(
          images: curState.images,
        ),
        ProductCommentsWidget(),
      ]);
    } else if (state is ProductErrorState) {
      var curState = state as ProductErrorState;
      return Center(
        child: Text(curState.msg),
      );
    } else {
      return const Center(
        child: Text('No data'),
      );
    }
    ;
  }
}

class ProductCommentsWidget extends StatefulWidget {
  const ProductCommentsWidget({super.key});

  @override
  State<ProductCommentsWidget> createState() => _ProductCommentsWidgetState();
}

class _ProductCommentsWidgetState extends State<ProductCommentsWidget> {
  final ScrollController _scrollController = ScrollController();
  // final CommentsBloc _bloc = CommentsBloc(repository: CommentsRepository());

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    var _bloc = context.read<CommentsBloc>();
    _bloc.add(CommentsLoadingEvent());
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_scrollListener)
      ..dispose();
    // _bloc.close();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      var _bloc = context.read<CommentsBloc>();
      _bloc.add(CommentsLoadingEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentsBloc, CommentsState>(
      builder: (context, state) {
        switch (state.status) {
          case BlocStatus.loading:
            return const CustomLoadingCircleWidget();
          case BlocStatus.loaded:
            return Column(
              children: [
                Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(
                                  color:
                                      AppConfig.primaryBackgroundColorGrey))),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Row(
                        children: state.buttonlist
                            .map(
                              (e) => GestureDetector(
                                onTap: () {
                                  // print('click type: ${e.type}');
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(
                                    left: 8,
                                  ),
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                  width: 90.w,
                                  decoration: BoxDecoration(
                                      color: state.type == e.type
                                          ? AppConfig.primaryColorPink
                                          : AppConfig
                                              .primaryBackgroundColorGrey),
                                  child: Center(
                                    child: Text(
                                      e.name!,
                                      style: TextStyle(
                                          color: state.type == e.type
                                              ? AppConfig
                                                  .primaryBackgroundColorRed
                                              : AppConfig
                                                  .primaryTextColorBlack),
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    )),
                Expanded(
                  flex: 12,
                  child: ListView.builder(
                      controller: _scrollController,
                      itemCount: state.models.length,
                      itemBuilder: (context, index) {
                        return ProductCommentsItemWidget(
                            model: state.models[index]);
                      }),
                  //     SingleChildScrollView(
                  //   controller: _scrollController,
                  //   child: Column(
                  //     children: state.model.list!
                  //         .map((e) => ProductCommentsItemWidget(model: e))
                  //         .toList(),
                  //   ),
                  // ),
                )
              ],
            );
          case BlocStatus.error:
            return Center(
              child: Column(
                children: [
                  CustomCachedNetworkImageWidget(
                      fit: BoxFit.cover,
                      height: 77.h,
                      width: 88.w,
                      imageUrl: 'https://timgs-v1.tongtongmall.com/009eb1c5'),
                  Text(
                    '这里空空如也~',
                    style: AppTextStyle.appTextStyle(size: 20.sp),
                  ),
                ],
              ),
            );
        }

        // if (state.status == BlocStatus.loaded) {
        //   if (state.models.isNotEmpty) {
        //     return Column(
        //       children: [
        //         Expanded(
        //             flex: 1,
        //             child: Padding(
        //               padding: const EdgeInsets.all(16.0),
        //               child: Row(
        //                 children: state.buttonlist
        //                     .map(
        //                       (e) => GestureDetector(
        //                         onTap: () {
        //                           // print('click type: ${e.type}');
        //                         },
        //                         child: Container(
        //                           margin: const EdgeInsets.only(
        //                             left: 8,
        //                           ),
        //                           height: 35.h,
        //                           width: 90.w,
        //                           decoration: BoxDecoration(
        //                               color: state.type == e.type
        //                                   ? AppConfig.primaryColorPink
        //                                   : AppConfig
        //                                       .primaryBackgroundColorGrey),
        //                           child: Center(
        //                             child: Text(
        //                               e.name!,
        //                               style: TextStyle(
        //                                   color: state.type == e.type
        //                                       ? AppConfig
        //                                           .primaryBackgroundColorRed
        //                                       : AppConfig
        //                                           .primaryTextColorBlack),
        //                             ),
        //                           ),
        //                         ),
        //                       ),
        //                     )
        //                     .toList(),
        //               ),
        //             )),
        //         Expanded(
        //           flex: 9,
        //           child: ListView.builder(
        //               controller: _scrollController,
        //               itemCount: state.models.length,
        //               itemBuilder: (context, index) {
        //                 return ProductCommentsItemWidget(
        //                     model: state.models[index]);
        //               }),
        //           //     SingleChildScrollView(
        //           //   controller: _scrollController,
        //           //   child: Column(
        //           //     children: state.model.list!
        //           //         .map((e) => ProductCommentsItemWidget(model: e))
        //           //         .toList(),
        //           //   ),
        //           // ),
        //         )
        //       ],
        //     );
        //   } else {
        //     return Center(
        //       child: Column(
        //         children: [
        //           CustomCachedNetworkImageWidget(
        //               fit: BoxFit.cover,
        //               height: 77.h,
        //               width: 88.w,
        //               imageUrl: 'https://timgs-v1.tongtongmall.com/009eb1c5'),
        //           Text(
        //             '这里空空如也~',
        //             style: AppTextStyle.appTextStyle(
        //                 AppConfig.primaryTextColorBlack, 20.sp),
        //           ),
        //         ],
        //       ),
        //     );
        //   }
        // } else if (state is CommentsErrorState) {
        //   return Center(
        //     child: Text(state.msg),
        //   );
        // } else {
        //   return const CustomLoadingCircleWidget();
        // }
      },
    );
  }
}

class ProductCommentsItemWidget extends StatelessWidget {
  const ProductCommentsItemWidget({
    super.key,
    required this.model,
  });

  final CommentModel model;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          border: Border.symmetric(
              horizontal: BorderSide(
                  color: AppConfig.primaryBackgroundColorGrey, width: 1.0.w))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  // Icon(Icons.person),
                  SizedBox(
                    height: 35.h,
                    width: 35.w,
                    child: CircleAvatar(
                      radius: 50.0,
                      backgroundColor: AppConfig.primaryColorPink,
                      backgroundImage:
                          AssetImage('assets/images/empty_avatar.png'),
                    ),
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(model.cuser!),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(model.ct.convertToString())
                    ],
                  ),
                ],
              ),
              RatingBar.builder(
                itemBuilder: (context, _) =>
                    Icon(Icons.star, color: Colors.amber),
                itemSize: 15.sp,
                initialRating: model.clevel!,
                onRatingUpdate: (rating) {},
              )
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            model.cc!,
            style: AppTextStyle.appTextStyle(size: 14.sp),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            '购买时间: ${model.buytime.convertToString()}',
            style: AppTextStyle.appTextStyle(
                color: AppConfig.secondColorGrey, size: 12.sp),
          ),
        ],
      ),
    );
  }
}

class ProductCommentWidget extends StatelessWidget {
  ProductCommentWidget({
    super.key,
    // required this.proComments,
  });
  // ProdetailCommentModel proComments;

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentsBloc, CommentsState>(
      builder: (context, state) {
        if (state.status == BlocStatus.loaded) {
          if (state.models.isNotEmpty) {
            return Column(
              children: [
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: state.buttonlist
                            .map(
                              (e) => GestureDetector(
                                onTap: () {
                                  // print('click type: ${e.type}');
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(
                                    left: 8,
                                  ),
                                  height: 35.h,
                                  width: 90.w,
                                  decoration: BoxDecoration(
                                      color:
                                          AppConfig.primaryBackgroundColorGrey),
                                  child: Center(
                                    child: Text(
                                      e.name!,
                                      style: TextStyle(
                                          color: AppConfig
                                              .primaryBackgroundColorRed),
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    )),
                Expanded(
                  flex: 9,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      children: state.models
                          .map((e) => Container(
                                padding: EdgeInsets.all(16.0),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: AppConfig
                                                .primaryBackgroundColorGrey,
                                            width: 1.0.w))),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            // Icon(Icons.person),
                                            SizedBox(
                                              height: 35.h,
                                              width: 35.w,
                                              child: CircleAvatar(
                                                radius: 50.0,
                                                backgroundColor:
                                                    AppConfig.primaryColorPink,
                                                backgroundImage: AssetImage(
                                                    'assets/images/empty_avatar.png'),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 15.w,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(e.cuser!),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                Text(e.ct.convertToString())
                                              ],
                                            ),
                                            // SizedBox(
                                            //   width: 120.w,
                                            // ),
                                          ],
                                        ),
                                        RatingBar.builder(
                                          itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color: Colors.amber),
                                          itemSize: 15.sp,
                                          initialRating: e.clevel!,
                                          onRatingUpdate: (rating) {},
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text(
                                      e.cc!,
                                      style: AppTextStyle.appTextStyle(
                                          size: 14.sp),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text(
                                      '购买时间: ${e.buytime.convertToString()}',
                                      style: AppTextStyle.appTextStyle(
                                          color: AppConfig.secondColorGrey,
                                          size: 12.sp),
                                    ),
                                  ],
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                )
              ],
            );
          } else {
            return Center(
              child: Column(
                children: [
                  CustomCachedNetworkImageWidget(
                      fit: BoxFit.cover,
                      height: 77.h,
                      width: 88.w,
                      imageUrl: 'https://timgs-v1.tongtongmall.com/009eb1c5'),
                  Text(
                    '这里空空如也~',
                    style: AppTextStyle.appTextStyle(size: 20.sp),
                  ),
                ],
              ),
            );
          }
        } else if (state is CommentsErrorState) {
          return Center(
            child: Text(state.msg),
          );
        } else {
          return const CustomLoadingCircleWidget();
        }
      },
    );
  }
}

class ProductDetailTabViewWidget extends StatelessWidget {
  ProductDetailTabViewWidget({super.key, required this.images});

  List<ProdetailImageModel> images;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: images
            .map((e) => CustomCachedNetworkImageWidget(imageUrl: e.url!))
            .toList(),
      ),
    );
  }
}
