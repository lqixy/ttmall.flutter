import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../bloc/cart/cart_coupon_detail_bloc.dart';
import '../../../bloc/navigator/navigator_bloc.dart';
import '../../../models/cart/cart_model.dart';
import '../../../shared/dependencies.dart';
import '../../../utils/app_config.dart';
import '../../../utils/route_config.dart';

class CartCouponDetailWidget extends StatelessWidget {
  const CartCouponDetailWidget({super.key});
  // final CartModel model;
  // final List<CartDetail> detail;
  // final double coupon;
  // final double realPay;
  // final double total;
  void _showBottomSheet(BuildContext context, CartModel model) {
    double discountTotal = model.detail!
        .fold(0, ((previousValue, element) => previousValue + element.value!));

    // List<Widget> details = [];
    var details = model.detail!
        .map((e) => CartDiscountItemWidget(e.label!, '-¥${e.value}'))
        .toList();
    details.insert(
      0,
      CartDiscountItemWidget('商品总额', '¥${model.total!.toStringAsFixed(2)}'),
    );
    details.add(CartDiscountItemWidget(
      '共优惠',
      '-¥$discountTotal',
      textStyle: TextStyle(color: AppConfig.primaryBackgroundColorRed),
    ));

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.35,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(top: 10.h),
                      child: Text(
                        '优惠明细',
                        style: AppTextStyle.appTextStyle(
                            size: 14.sp, fw: FontWeight.bold),
                      )),
                  Positioned(
                    top: 8.h,
                    right: 5.w,
                    child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.close,
                          color: AppConfig.secondColorGrey,
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              SingleChildScrollView(
                child: Column(
                  children: details,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    context.read<CartCouponDetailBloc>().add(CartCouponDetailLoadEvent());
    return BlocBuilder<CartCouponDetailBloc, CartCouponDetailState>(
      builder: (context, state) {
        if (state is CartCouponDetailLoadedState) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.06,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: AppConfig.primaryWhite,
                border: Border.all(
                    color: AppConfig.primaryBackgroundColorGrey, width: 0.5)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(flex: 1, child: Container()),
                Expanded(
                    flex: 9,
                    child: Column(
                      mainAxisAlignment: state.model.coupon != 0
                          ? MainAxisAlignment.spaceAround
                          : MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              '合    计:',
                              style: TextStyle(fontSize: 10.sp),
                            ),
                            Text(
                              '¥${state.model.realPay}',
                              style: AppTextStyle.appTextStyle(
                                  color: AppConfig.primaryBackgroundColorRed,
                                  size: 14.sp),
                            )
                          ],
                        ),
                        Visibility(
                          visible: state.model.coupon != 0,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  '立减: ¥ ${state.model.coupon}',
                                  style: TextStyle(fontSize: 10.sp),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    // print('优惠明细');
                                    _showBottomSheet(context, state.model);
                                  },
                                  child: Text(
                                    '优惠明细',
                                    style: AppTextStyle.appTextStyle(
                                        color:
                                            AppConfig.primaryBackgroundColorRed,
                                        size: 10.sp),
                                  ),
                                ),
                              ),
                              Expanded(flex: 1, child: Container())
                            ],
                          ),
                        )
                      ],
                    )),
                Expanded(
                  flex: 4,
                  child: GestureDetector(
                    onTap: () {
                      BlocProvider.of<NavigatorBloc>(context).add(
                          NavigatorPushNamedEvent(
                              context, RouteConfig.OrderConfirm));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                          color: AppConfig.primaryBackgroundColorRed),
                      child: Text(
                        '去结算(0)',
                        style: AppTextStyle.appTextStyle(
                            color: AppConfig.primaryWhite, size: 14.sp),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}

class CartDiscountItemWidget extends StatelessWidget {
  const CartDiscountItemWidget(this.title, this.money,
      {super.key, this.textStyle});

  final String title;
  final String money;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(
            money,
            style: textStyle,
          ),
        ],
      ),
    );
  }
}
