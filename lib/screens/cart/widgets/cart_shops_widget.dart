import 'package:flutter/services.dart';
import 'package:ttmall/bloc/cart/cart_coupon_detail_bloc.dart';
import 'package:ttmall/shared/dependencies.dart';

import '../../../bloc/cart/cart_bloc.dart';
import '../../../models/cart/api/request/api_cart_add_request.dart';
import '../../../models/cart/cart_model.dart';
import '../../../models/cart/cart_operate_type.dart';
import '../../../shared/custom_cached_network_image_widget.dart';
import '../../../utils/app_config.dart';
import 'cart_widget.dart';

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
    // _reloadCart();
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
    // _reloadCart();
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
    context.read<CartCouponDetailBloc>().add(CartCouponDetailLoadEvent());
  }

  ApiCartGoodsImte _getGoodsItem(CartGoodsModel model, bool value) {
    return ApiCartGoodsImte(
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
                                                              child: Column(
                                                                // mainAxisAlignment:
                                                                //     MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          top:
                                                                              8.0),
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
                                                                  ),
                                                                  Expanded(
                                                                    flex: 2,
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                          goods
                                                                              .sellprice!,
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
    List<ApiCartGoodsImte> goods = [
      ApiCartGoodsImte(
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
