import 'package:flutter/services.dart';
import 'package:ttmall/bloc/navigator/navigator_bloc.dart';
import 'package:ttmall/models/cart/api/request/api_cart_add_request.dart';
import 'package:ttmall/models/cart/cart_operate_type.dart';
import 'package:ttmall/shared/dependencies.dart';
import 'package:ttmall/utils/route_config.dart';

import '../../../bloc/cart/cart_bloc.dart';
import '../../../models/cart/cart_model.dart';
import '../../../shared/custom_cached_network_image_widget.dart';
import '../../../shared/custom_error_widget.dart';
import '../../../shared/custom_loading_circle_widget.dart';
import '../../../shared/custom_no_data_widget.dart';
import '../../../utils/app_config.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({super.key});

  // const CartWidget(this.model, {super.key});
  // final CartModel model;
  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  @override
  void initState() {
    super.initState();
    context.read<CartBloc>().add(CartLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    // context.read<CartBloc>().add(CartLoadEvent());
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoadedState) {
          return Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.94,
                child: SingleChildScrollView(
                  child: Column(
                    children: state.model.list!
                        .map((e) => CartShopsWidget(e))
                        .toList(),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: CartFootWidget(state.model.coupon!, state.model.realPay!,
                    state.model.total!, state.model.detail!),
              ),
            ],
          );
        } else if (state is CartErrorState) {
          return CustomErrorWidget(state.msg);
        } else {
          return const CustomLoadingCircleWidget();
        }
      },
    );
  }
}

class CartFootWidget extends StatelessWidget {
  const CartFootWidget(this.coupon, this.realPay, this.total, this.detail,
      {super.key});
  // final CartModel model;
  final List<CartDetail> detail;
  final double coupon;
  final double realPay;
  final double total;
  void _showBottomSheet(BuildContext context, List<CartDetail> detail) {
    double discountTotal = detail.fold(
        0, ((previousValue, element) => previousValue + element.value!));

    // List<Widget> details = [];
    var details = detail
        .map((e) => CartDiscountItemWidget(e.label!, '-¥${e.value}'))
        .toList();
    details.insert(
      0,
      CartDiscountItemWidget('商品总额', '¥${total!.toStringAsFixed(2)}'),
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
              mainAxisAlignment: coupon != 0
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
                      '¥$realPay',
                      style: AppTextStyle.appTextStyle(
                          color: AppConfig.primaryBackgroundColorRed,
                          size: 14.sp),
                    )
                  ],
                ),
                Visibility(
                  visible: coupon != 0,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          '立减: ¥ $coupon',
                          style: TextStyle(fontSize: 10.sp),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            // print('优惠明细');
                            _showBottomSheet(context, detail);
                          },
                          child: Text(
                            '优惠明细',
                            style: AppTextStyle.appTextStyle(
                                color: AppConfig.primaryBackgroundColorRed,
                                size: 10.sp),
                          ),
                        ),
                      ),
                      Expanded(flex: 1, child: Container())
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: GestureDetector(
              onTap: () {
                BlocProvider.of<NavigatorBloc>(context).add(
                    NavigatorPushNamedEvent(context, RouteConfig.OrderConfirm));
              },
              child: Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height,
                decoration:
                    BoxDecoration(color: AppConfig.primaryBackgroundColorRed),
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

class CartShopsWidget extends StatefulWidget {
  const CartShopsWidget(this.shopModel, {super.key});
  final CartShopsModel shopModel;
  @override
  State<CartShopsWidget> createState() => _CartShopsWidgetState();
}

class _CartShopsWidgetState extends State<CartShopsWidget> {
  bool shopsIsCheck = true;
  bool storeIsCheck = true;

  void _shopChecked(bool value) {
    setState(() {
      shopsIsCheck = value;
      for (var element in widget.shopModel.list!) {
        for (var e in element.data!) {
          e.ischeck = value;
        }
      }
    });

    _shopUpdateCart(value);
    _reloadCart();
  }

  void _shopUpdateCart(bool value) {
    List<ApiCartGoodsImte> goods = [];

    for (var element in widget.shopModel.list!) {
      for (var e in element.data!) {
        goods.add(_getGoodsItem(e, value));
      }
    }

    _updateCart(goods);
  }

  void _storeChecked(List<CartGoodsModel> storeModel, bool value) {
    setState(() {
      for (var element in storeModel) {
        element.ischeck = value;
      }
    });
    _storeUpdateCart(storeModel, value);
    _reloadCart();
  }

  void _storeUpdateCart(List<CartGoodsModel> storeModel, bool value) {
    var goods = storeModel.map((e) => _getGoodsItem(e, value)).toList();
    _updateCart(goods);
  }

  void _itemChecked(CartGoodsModel item, bool value) {
    setState(() {
      item.ischeck = value;
    });

    _updateCart([_getGoodsItem(item, value)]);
    _reloadCart();
  }

  void _reloadCart() {
    context.read<CartBloc>().add(CartLoadEvent());
  }

  ApiCartGoodsImte _getGoodsItem(CartGoodsModel model, bool value) {
    // return ApiCartGoodsImte(
    //     itemid: model.itemid,
    //     type: model.type,
    //     buycount: model.purchasenum,
    //     operatetype: value
    //         ? CartOperateType.update.index
    //         : CartOperateType.uncheck.index);
    return ApiCartGoodsItemUpdate(
        itemid: model.itemid,
        type: model.type,
        buycount: model.purchasenum,
        operatetype: value
            ? CartOperateType.update.index
            : CartOperateType.uncheck.index);
  }

  void _updateCart(List<ApiCartGoodsImte> goods) {
    BlocProvider.of<CartBloc>(context).add(CartUpdateEvent(goods));
  }

  void _initCheck() {
    shopsIsCheck = !widget.shopModel.list!
        .any((element) => element.data!.any((e) => !e.ischeck!));
  }

  @override
  Widget build(BuildContext context) {
    _initCheck();
    return Column(
      children: [
        SizedBox(
          height: 10.h,
        ),
        Container(
          color: AppConfig.primaryWhite,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            width: 0.2, color: AppConfig.secondColorGrey))),
                height: 35.h,
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Checkbox(
                          activeColor: AppConfig.primaryBackgroundColorRed,
                          shape: const CircleBorder(),
                          value: shopsIsCheck,
                          onChanged: (value) {
                            _shopChecked(value!);
                          },
                        )),
                    Expanded(
                        flex: 1,
                        child: Image(
                          height: 20.h,
                          image:
                              const AssetImage('assets/images/shop_icon.png'),
                        )),
                    Expanded(
                        flex: 8,
                        child: Text(
                          widget.shopModel.shopsName ?? '',
                          style: AppTextStyle.appTextStyle(
                              size: 14.sp, fw: FontWeight.bold),
                        ))
                  ],
                ),
              ),
              Column(
                children: widget.shopModel.list!
                    .map((storeModel) =>
                        // CartStoreWidget(e)
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 0.2,
                                          color: AppConfig.secondColorGrey))),
                              height: 35.h,
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Checkbox(
                                      activeColor:
                                          AppConfig.primaryBackgroundColorRed,
                                      shape: const CircleBorder(),
                                      value: !storeModel.data!
                                          .any((element) => !element.ischeck!),
                                      onChanged: (value) {
                                        _storeChecked(storeModel.data!, value!);
                                        // setState(() {
                                        //   for (var element
                                        //       in storeModel.data!) {
                                        //     element.ischeck = value;
                                        //   }
                                        // });
                                      },
                                    ),
                                  ),
                                  Expanded(
                                      flex: 7,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 16),
                                        child: Text(
                                          storeModel.address!,
                                          style: AppTextStyle.appTextStyle(
                                              size: 14.sp, fw: FontWeight.bold),
                                        ),
                                      )),
                                  Expanded(
                                      flex: 2,
                                      child: Text(
                                        storeModel.freebie!,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTextStyle.appTextStyle(
                                            color: AppConfig.secondColorGrey,
                                            size: 12.sp),
                                      ))
                                ],
                              ),
                            ),
                            Column(
                              children: storeModel.data!
                                  .map((goods) => SizedBox(
                                            height: 100.h,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    flex: 1,
                                                    child: Checkbox(
                                                      activeColor: AppConfig
                                                          .primaryBackgroundColorRed,
                                                      // checkColor: AppConfig.primaryBackgroundColorGrey,
                                                      shape:
                                                          const CircleBorder(),
                                                      value: goods.ischeck,
                                                      onChanged: (value) {
                                                        _itemChecked(
                                                            goods, value!);
                                                      },
                                                    )),
                                                Expanded(
                                                    flex: 9,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          border: Border(
                                                              bottom:
                                                                  BorderSide(
                                                        color: AppConfig
                                                            .primaryBackgroundColorGrey,
                                                      ))),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                              flex: 1,
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        8),
                                                                child: CustomCachedNetworkImageWidget(
                                                                    imageUrl: goods
                                                                        .goodsurl!),
                                                              )),
                                                          Expanded(
                                                              flex: 2,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left: 8,
                                                                        right:
                                                                            8,
                                                                        top: 8),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  // mainAxisAlignment:
                                                                  //     MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Text(
                                                                        goods
                                                                            .goodsname!,
                                                                        maxLines:
                                                                            2,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: AppTextStyle.appTextStyle(
                                                                            size:
                                                                                12.sp),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 2,
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                            '¥${goods.sellprice!}',
                                                                            style: AppTextStyle.appTextStyle(
                                                                                color: AppConfig.primaryBackgroundColorRed,
                                                                                size: 12.sp,
                                                                                fw: FontWeight.bold),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                CartCountOperationWidget(goods),
                                                                                Offstage(
                                                                                    offstage: goods.stock != 1,
                                                                                    child: Text(
                                                                                      '当前库存为1件',
                                                                                      style: AppTextStyle.appTextStyle(color: AppConfig.primaryBackgroundColorRed, size: 10.sp),
                                                                                    ))
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              )),
                                                        ],
                                                      ),
                                                    ))
                                              ],
                                            ),
                                          )
                                      // CartProductItemWidget(goods)
                                      )
                                  .toList(),
                            ),
                          ],
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CartCountOperationWidget extends StatefulWidget {
  const CartCountOperationWidget(this.goods, {super.key});
  // final String text;
  final CartGoodsModel goods;
  @override
  State<CartCountOperationWidget> createState() =>
      _CartCountOperationWidgetState();
}

class _CartCountOperationWidgetState extends State<CartCountOperationWidget> {
  late final TextEditingController _textEditingController =
      TextEditingController(text: '${widget.goods.purchasenum}');

  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // _textEditingController = TextEditingController(text: ' widget.text');
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _updateCart(int count, CartOperateType operateType) {
    List<ApiCartGoodsItemUpdate> goods = [
      // ApiCartGoodsImte(
      //     itemid: widget.goods.itemid,
      //     buycount: count,
      //     type: widget.goods.type,
      //     operatetype: operateType.index)
      ApiCartGoodsItemUpdate(
          itemid: widget.goods.itemid,
          buycount: count,
          type: widget.goods.type,
          operatetype: operateType.index)
    ];
    BlocProvider.of<CartBloc>(context).add(CartUpdateEvent(goods));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        children: [
          CartButtonWidget(
            '-',
            () {
              var countStr = _textEditingController.text;
              var count = int.tryParse(countStr);
              if (count == null || count <= 1) {
                _textEditingController.text = '1';
              } else {
                _textEditingController.text = '${count - 1}';
              }

              if (count != null) {
                // BlocProvider.of<CartBloc>(context)
                //     .add(CartUpdateEvent(widget.goods.itemid!, count, 1));
                _updateCart(count, CartOperateType.update);
              }
            },
            // color:  AppConfig.primaryWhite,
          ),
          CartTextFieldWidget(_textEditingController),
          CartButtonWidget(
            '+',
            () {
              var countStr = _textEditingController.text;
              var count = int.tryParse(countStr);
              if (count == null || count < 1) {
                _textEditingController.text = '1';
              } else if (count < 99) {
                _textEditingController.text = '${count + 1}';
              } else {
                _textEditingController.text = '99';
              }

              if (count != null) {
                // BlocProvider.of<CartBloc>(context)
                //     .add(CartUpdateEvent(widget.goods.itemid!, count, 1));
                _updateCart(count, CartOperateType.update);
              }
            },
            onLongPress: () {},
          ),
        ],
      ),
    );
    ;
  }
}

class CartTextFieldWidget extends StatelessWidget {
  const CartTextFieldWidget(
    this._textEditingController, {
    super.key,
  });

  final TextEditingController _textEditingController;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20.h,
      width: 30.w,
      child: TextField(
        controller: _textEditingController,
        cursorColor: AppConfig.primaryBackgroundColorGrey,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          TextInputFormatter.withFunction((oldValue, newValue) {
            final int? number = int.tryParse(newValue.text);
            if (number == null || number < 1 || number > 99) {
              return oldValue;
            } else {
              return newValue;
            }
          }),
        ],
        textAlign: TextAlign.center,
        style: AppTextStyle.appTextStyle(size: 14.sp),
      ),
    );
  }
}

class CartButtonWidget extends StatelessWidget {
  const CartButtonWidget(
    this.title,
    this.onTap, {
    super.key,
    this.color = Colors.white,
    this.onLongPress,
  });

  final Function() onTap;
  final Function()? onLongPress;
  final String title;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        alignment: Alignment.center,
        height: 20.h,
        width: 20.w,
        decoration: BoxDecoration(
            color: color,
            border: Border.all(
                width: 0.5, color: AppConfig.primaryBackgroundColorGrey)),
        child: Text(
          title,
          style: AppTextStyle.appTextStyle(
              color: AppConfig.secondColorGrey, size: 12.sp),
        ),
      ),
    );
  }
}
