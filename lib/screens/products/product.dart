import 'dart:async';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:ttmall/bloc/navigator/navigator_bloc.dart';

import 'package:ttmall/bloc/products/comments_bloc.dart';
import 'package:ttmall/bloc/products/product_bloc.dart';
import 'package:ttmall/models/products/prodetail_comment_model.dart';
import 'package:ttmall/models/products/prodetail_image_model.dart';
import 'package:ttmall/repositories/cart/cart_repository.dart';

import 'package:ttmall/screens/products/widgets/product_info_tabview_widget.dart';
import 'package:ttmall/screens/products/widgets/product_tabbar_widget.dart';
import 'package:ttmall/shared/custom_badge_widget.dart';
import 'package:ttmall/shared/custom_error_widget.dart';
import 'package:ttmall/shared/custom_loading_circle_widget.dart';
import 'package:ttmall/shared/dependencies.dart';
import 'package:ttmall/utils/app_config.dart';
import 'package:ttmall/utils/app_extensions.dart';
import '../../bloc/cart/cart_bloc.dart';
import '../../shared/custom_cached_network_image_widget.dart';
import '../../shared/custom_toast_widget.dart';
import '../../utils/route_config.dart';

class ProductScreen extends StatelessWidget {
  final String goodsId;

  const ProductScreen(this.goodsId, {super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProductBloc>().add(ProductLoadEvent(goodsId));

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppConfig.primaryWhite,
        appBar: AppBar(
          title: const ProductTabBarWidget(),
          elevation: 0,
          backgroundColor: AppConfig.primaryWhite,
          iconTheme: IconThemeData(color: AppConfig.primaryTextColorBlack),
        ),
        body: SafeArea(child: ProductBodyWidget()),
        // bottomNavigationBar:
        //     ProductBottomWidget(isVisibility: isVisibility),
      ),
    );
  }
}

class ProductBodyWidget extends StatelessWidget {
  const ProductBodyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoadedState) {
          var isVisibility =
              state.model.goodsstandard!.any((element) => element.stock != 0);

          return Stack(
            children: [
              TabBarView(children: [
                ProductInfoTabViewWidget(
                  state,
                ),
                ProductDetailTabViewWidget(
                  images: state.images,
                ),
                ProductCommentsWidget(),
              ]),
              // SizedBox(
              //   height: 20.h,
              // ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: ProductBottomBarWidgetV2(
                    isVisibility, state.model.goodsid!, state.cartCount),
              ),
            ],
          );
        } else if (state is ProductErrorState) {
          return CustomErrorWidget(state.msg);
        } else {
          return const CustomLoadingCircleWidget();
        }
      },
    );
  }
}

class ProductBottomBarWidgetV2 extends StatefulWidget {
  ProductBottomBarWidgetV2(
    this.isVisibility,
    this.goodsId,
    this.cartCount, {
    super.key,
  });

  final bool isVisibility;
  final String goodsId;
  late int cartCount;
  @override
  State<ProductBottomBarWidgetV2> createState() =>
      _ProductBottomBarWidgetV2State();
}

class _ProductBottomBarWidgetV2State extends State<ProductBottomBarWidgetV2> {
  final toast = FToast();
  Timer? _timer;

  void _handleTap() {
    if (_timer != null && _timer!.isActive) {
      return;
    }
    _addToCart();

    _timer = Timer(const Duration(seconds: 1), () {
      _timer = null;
    });
  }

  void _addToCart() {
    BlocProvider.of<CartBloc>(context).add(CartInsertEvent(widget.goodsId));
    // customShowSnackBar(context, '成功加入购物车');
    toast.showToast(
        gravity: ToastGravity.CENTER, child: CustomToastWidget('成功加入购物车'));
    // toast.showToast(
    //     msg: '成功加入购物车', gravity: ToastGravity.CENTER);
    _setCartCount();
  }

  @override
  void initState() {
    super.initState();
    toast.init(context);
  }

  void _setCartCount() {
    // getCartCount();
    setState(() {
      widget.cartCount += 1;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.07,
      decoration: BoxDecoration(
          color: AppConfig.primaryWhite,
          border: Border(
            top: BorderSide(
                color: AppConfig.primaryBackgroundColorGrey, width: 1),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 1,
            child: Icon(
              Icons.sms_outlined,
              // size: 30.sp,
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                BlocProvider.of<NavigatorBloc>(context)
                    .add(NavigatorPushNamedEvent(
                  context,
                  RouteConfig.Cart,
                ));
              },
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                // alignment: Alignment.center,
                // color: Colors.amber,
                child: Stack(children: [
                  Container(
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.shopping_cart_outlined,
                      // size: 30.sp,
                    ),
                  ),
                  Visibility(
                    visible: widget.cartCount != 0,
                    child: Positioned(
                        top: 0,
                        right: 10,
                        child: CustomBadgeWidget(
                          widget.cartCount,
                          height: 15.h,
                          width: 15.w,
                          fontSize: 10.sp,
                        )),
                  )
                ]),
              ),
            ),
          ),
          Visibility(
            visible: widget.isVisibility,
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
            visible: widget.isVisibility,
            maintainSize: false,
            child: Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () {
                  _handleTap();
                },
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
          ),
          Visibility(
            visible: !widget.isVisibility,
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
    );
  }
}

// class ProductBottomBarWidget extends StatelessWidget {
//   const ProductBottomBarWidget(
//     this.isVisibility,
//     this.goodsId, {
//     super.key,
//   });

//   final bool isVisibility;
//   final String goodsId;
//   // final int cartCount;

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<CartBloc, CartState>(
//       builder: (context, state) {
//         var cartCount = 0;
//         if (state is CartCountState) {
//           cartCount = state.count;
//         }
//         return Container(
//           height: MediaQuery.of(context).size.height * 0.07,
//           decoration: BoxDecoration(
//               color: AppConfig.primaryWhite,
//               border: Border(
//                 top: BorderSide(
//                     color: AppConfig.primaryBackgroundColorGrey, width: 1),
//               )),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Expanded(
//                 flex: 1,
//                 child: Icon(
//                   Icons.sms_outlined,
//                   // size: 30.sp,
//                 ),
//               ),
//               Expanded(
//                 flex: 1,
//                 child: GestureDetector(
//                   onTap: () {
//                     BlocProvider.of<NavigatorBloc>(context)
//                         .add(NavigatorPushNamedEvent(
//                       context,
//                       RouteConfig.Cart,
//                     ));
//                   },
//                   child: SizedBox(
//                     height: MediaQuery.of(context).size.height,
//                     width: MediaQuery.of(context).size.width,
//                     // alignment: Alignment.center,
//                     // color: Colors.amber,
//                     child: Stack(children: [
//                       Container(
//                         alignment: Alignment.center,
//                         child: const Icon(
//                           Icons.shopping_cart_outlined,
//                           // size: 30.sp,
//                         ),
//                       ),
//                       Visibility(
//                         visible: cartCount != 0,
//                         child: Positioned(
//                             top: 0,
//                             right: 10,
//                             child: CustomBadgeWidget(
//                               cartCount,
//                               height: 15.h,
//                               width: 15.w,
//                               fontSize: 10.sp,
//                             )),
//                       )
//                     ]),
//                   ),
//                 ),
//               ),
//               Visibility(
//                 visible: isVisibility,
//                 maintainSize: false,
//                 child: Expanded(
//                   flex: 2,
//                   child: Container(
//                       color: AppConfig.primaryBackgroundColorRed,
//                       child: Center(
//                           child: Text(
//                         '立即购买',
//                         style: AppTextStyle.appTextStyle(
//                             color: AppConfig.primaryWhite, size: 16.sp),
//                       ))),
//                 ),
//               ),
//               Visibility(
//                 visible: isVisibility,
//                 maintainSize: false,
//                 child: Expanded(
//                   flex: 2,
//                   child: GestureDetector(
//                     onTap: () {
//                       BlocProvider.of<CartBloc>(context)
//                           .add(CartInsertEvent(goodsId));
//                       customShowSnackBar(context, '成功加入购物车');
//                     },
//                     child: Container(
//                         color: AppConfig.primaryTextColorBlack,
//                         child: Center(
//                             child: Text(
//                           '加入购物车',
//                           style: AppTextStyle.appTextStyle(
//                               color: AppConfig.primaryWhite, size: 16.sp),
//                         ))),
//                   ),
//                 ),
//               ),
//               Visibility(
//                 visible: !isVisibility,
//                 maintainSize: false,
//                 child: Expanded(
//                   flex: 4,
//                   child: Container(
//                       color: AppConfig.primaryColorYellow,
//                       child: Center(
//                           child: Text(
//                         '到货提醒',
//                         style: AppTextStyle.appTextStyle(
//                             size: 16.sp, fw: FontWeight.bold),
//                       ))),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

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
                ),
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
        children: [
          Column(
            children: images
                .map((e) => CustomCachedNetworkImageWidget(imageUrl: e.url!))
                .toList(),
          ),
          SizedBox(
            height: 30.h,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
        ],
      ),
    );
  }
}
