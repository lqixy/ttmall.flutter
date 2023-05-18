import 'package:ttmall/shared/custom_button_widget.dart';
import 'package:ttmall/shared/custom_cached_network_image_widget.dart';
import 'package:ttmall/shared/custom_error_widget.dart';
import 'package:ttmall/shared/custom_loading_circle_widget.dart';
import 'package:ttmall/shared/custom_no_data_widget.dart';
import 'package:ttmall/shared/dependencies.dart';
import 'package:ttmall/utils/app_config.dart';
import 'package:ttmall/utils/app_extensions.dart';
import 'package:ttmall/utils/route_config.dart';

import '../../../bloc/orders/confirm/order_confirm_bloc.dart';
import '../../../models/address/address_model.dart';
import '../../../models/orders/order_confirm_model.dart';

class OrderConfirmScreen extends StatelessWidget {
  const OrderConfirmScreen({super.key});

  void _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return CustomDialogView('确认要放弃购买吗?');
        });
  }

  @override
  Widget build(BuildContext context) {
    context.read<OrderConfirmBloc>().add(OrderConfirmLoadEvent());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppConfig.primaryWhite,
        foregroundColor: AppConfig.secondColorGrey,
        title: Text(
          '确认订单',
          style: AppTextStyle.appTextStyle(size: 14.sp, fw: FontWeight.w600),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              _showDialog(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: AppConfig.primaryBackgroundColorGrey,
          child: BlocBuilder<OrderConfirmBloc, OrderConfirmState>(
            builder: (context, state) {
              if (state is OrderConfirmLoadingState) {
                return const CustomLoadingCircleWidget();
              } else if (state is OrderConfirmLoadedState) {
                return Stack(children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 6.h,
                        ),
                        // 地址
                        OrderAddressWidget(state.model.address!),
                        // 商品
                        Column(
                          children: state.model.shops!
                              .map((e) => OrderShopsWidget(e))
                              .toList(),
                        ),

                        // 积分
                        Container(
                          color: AppConfig.primaryWhite,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('可用${state.model.score}积分抵扣元'),
                                    Checkbox(
                                        shape: CircleBorder(),
                                        value: false,
                                        onChanged: (value) {})
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('平台优惠券'),
                                    Text(
                                      '${state.model.couponlist!.length}张可用',
                                      style: AppTextStyle.appTextStyle(
                                          color: AppConfig
                                              .primaryBackgroundColorRed,
                                          size: 12.sp),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                        )
                      ],
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.08,
                        color: AppConfig.primaryWhite,
                        child: Row(
                          children: [
                            Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Row(
                                    children: [
                                      Text(
                                        '实付款:  ',
                                        style: AppTextStyle.appTextStyle(
                                            color: AppConfig.secondColorGrey,
                                            size: 12.sp),
                                      ),
                                      Text(
                                        '¥${state.model.pay!}',
                                        style: AppTextStyle.appTextStyle(
                                            color: AppConfig
                                                .primaryBackgroundColorRed,
                                            fw: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                )),
                            Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.center,
                                  height: MediaQuery.of(context).size.height,
                                  color: AppConfig.primaryBackgroundColorRed,
                                  child: Text(
                                    '提交订单',
                                    style: AppTextStyle.appTextStyle(
                                        color: AppConfig.primaryWhite),
                                  ),
                                ))
                          ],
                        ),
                      ))
                ]);
              } else if (state is OrderConfirmErrorState) {
                return CustomErrorWidget(state.msg);
              } else {
                return const CustomLoadingCircleWidget();
              }
            },
          ),
        ),
      ),
    );
  }
}

class OrderShopsWidget extends StatelessWidget {
  const OrderShopsWidget(this.shops, {super.key});
  final OrderShopsModel shops;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 6.h,
        ),
        // 商品
        Container(
          color: AppConfig.primaryWhite,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/shop_icon.png',
                      width: 20.w,
                      height: 20.h,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(shops.shopsname!),
                  ],
                ),
                Column(
                  children:
                      shops.goods!.map((e) => OrderStoreWidget(e)).toList(),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              color: AppConfig.primaryBackgroundColorGrey),
                          bottom: BorderSide(
                              color: AppConfig.primaryBackgroundColorGrey))),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '店铺优惠券',
                              style: AppTextStyle.appTextStyle(size: 13.sp),
                            ),
                            Text(
                              '${shops.couponlist!.length}张可用',
                              style: AppTextStyle.appTextStyle(
                                  color: AppConfig.primaryBackgroundColorRed,
                                  size: 10.sp),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: shops.detail!
                            .map((e) => Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        e.label!,
                                        style: AppTextStyle.appTextStyle(
                                            size: 13.sp),
                                      ),
                                      Text(
                                        e.value!,
                                        style: AppTextStyle.appTextStyle(
                                            size: 10.sp),
                                      ),
                                    ],
                                  ),
                                ))
                            .toList(),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                '订单备注',
                                style: AppTextStyle.appTextStyle(size: 13.sp),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: SizedBox(
                                height: 16.h,
                                child: TextField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: '选填',
                                      hintStyle: AppTextStyle.appTextStyle(
                                          size: 10.sp)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '共${shops.count}件 小计:  ',
                        style: AppTextStyle.appTextStyle(size: 12.sp),
                      ),
                      Text(
                        '¥ ${shops.subtotal}',
                        style: AppTextStyle.appTextStyle(
                            color: AppConfig.primaryBackgroundColorRed,
                            size: 12.sp),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(
          height: 6.h,
        ),
        Container(),
      ],
    );
  }
}

class OrderStoreWidget extends StatelessWidget {
  const OrderStoreWidget(this.store, {super.key});
  final OrderStoreModel store;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: store.data!.map((e) => OrderGoodsWidget(e)).toList(),
    );
  }
}

class OrderGoodsWidget extends StatelessWidget {
  const OrderGoodsWidget(this.goods, {super.key});

  final OrderGoodsModel goods;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: CustomCachedNetworkImageWidget(imageUrl: goods.goodsurl!),
          ),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    goods.goodsname!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.appTextStyle(size: 13.sp),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '¥  ${goods.sellprice}',
                        style: AppTextStyle.appTextStyle(
                            color: AppConfig.primaryBackgroundColorRed,
                            size: 14.sp),
                      ),
                      Text('x${goods.purchasenum}'),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class OrderAddressWidget extends StatelessWidget {
  const OrderAddressWidget(this.address, {super.key});

  final AddressModel address;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppConfig.primaryWhite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomCachedNetworkImageWidget(
              height: 3.h,
              imageUrl: 'https://timgs-v1.tongtongmall.com/835df526'),
          Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, bottom: 8, top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                          '${address.name}    ${address.phone.hidePhoneNumber()}'),
                    ),
                    Text(
                      '${address.addr}',
                      style: AppTextStyle.appTextStyle(
                          color: AppConfig.secondColorGrey, size: 10.sp),
                    )
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppConfig.primaryBackgroundColorGrey,
                  size: 16.sp,
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.03,
            margin: EdgeInsets.only(left: 8, right: 8, bottom: 20),
            padding: EdgeInsets.symmetric(horizontal: 8),
            color: AppConfig.primaryColorPink,
            child: Text(
              '收货不便时，可选择上门自提服务！',
              style: AppTextStyle.appTextStyle(
                  color: AppConfig.primaryBackgroundColorRed, size: 10.sp),
            ),
          )
        ],
      ),
    );
  }
}

// class OrderAddressWidget extends StatefulWidget {
//   const OrderAddressWidget({super.key});

//   @override
//   State<OrderAddressWidget> createState() => _OrderAddressWidgetState();
// }

// class _OrderAddressWidgetState extends State<OrderAddressWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }

class CustomDialogView extends Dialog {
  final String title;
  // final String? message;

  const CustomDialogView(this.title);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.26,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: const BoxDecoration(
          color: AppConfig.primaryWhite,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 20),
              child: Text(
                title,
                style: AppTextStyle.appTextStyle(
                    size: 14.sp,
                    fw: FontWeight.bold,
                    textDecoration: TextDecoration.none),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomButtonWidget(
                    title: '取消',
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width * 0.3,
                    fontSize: 12.sp,
                    border:
                        Border.all(color: AppConfig.primaryBackgroundColorGrey),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    backgroundColor: AppConfig.primaryWhite,
                    fontColor: AppConfig.primaryTextColorBlack,
                  ),
                  CustomButtonWidget(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.3,
                      fontSize: 12.sp,
                      title: '确认',
                      onTap: () {
                        Navigator.of(context)
                            .popUntil(ModalRoute.withName(RouteConfig.Cart));
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
