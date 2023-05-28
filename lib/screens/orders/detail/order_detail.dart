import 'dart:async';

import 'package:ttmall/models/orders/api/response/api_order_detail_response.dart';
import 'package:ttmall/shared/custom_button_widget.dart';
import 'package:ttmall/shared/custom_cached_network_image_widget.dart';
import 'package:ttmall/shared/custom_error_widget.dart';
import 'package:ttmall/shared/custom_loading_circle_widget.dart';
import 'package:ttmall/shared/custom_sizedbox_widget.dart';
import 'package:ttmall/shared/dependencies.dart';
import 'package:ttmall/utils/app_config.dart';
import 'package:ttmall/utils/app_extensions.dart';

import '../../../bloc/orders/order_bloc.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen(this.orderSettlementId, {super.key});
  final String orderSettlementId;

  @override
  Widget build(BuildContext context) {
    context.read<OrderBloc>().add(OrderDetailLoadEvent(orderSettlementId));
    return Scaffold(
      backgroundColor: AppConfig.primaryWhite,
      appBar: AppBar(
        backgroundColor: AppConfig.primaryWhite,
        elevation: 0,
        title: Text(
          '订单详情',
          style: AppTextStyle.appTextStyle(
              color: AppConfig.primaryTextColorBlack, size: 14.sp),
        ),
        centerTitle: true,
        foregroundColor: AppConfig.secondBackgroundColorGrey,
      ),
      body: SafeArea(
        child: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            if (state is OrderDetailLoadedState) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.08,
                      color: AppConfig.primaryBackgroundColorRed,
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 18, horizontal: 8),
                            child: Image(
                                image: AssetImage('assets/images/message.png')),
                          ),
                          Text(
                            state.detail.orderStatusDes,
                            style: AppTextStyle.appTextStyle(
                                color: AppConfig.primaryWhite, size: 15.sp),
                          ),
                        ],
                      ),
                    ),
                    DetailTitleWidget(
                        'assets/images/document.png',
                        '订单号:  ${state.detail.orderidshow}',
                        '下单时间:  ${state.detail.time.convertToString()}'),
                    state.detail.logistics != null &&
                            state.detail.logistics!.kddh!.isNotEmpty
                        ? DetailTitleWidget(
                            'assets/images/house.png',
                            '${state.detail.from}',
                            '${state.detail.logistics?.kdsj}:  ${state.detail.logistics?.kddh}')
                        : SizedBox.shrink(),
                    DetailTitleWidget(
                      'assets/images/local.png',
                      '${state.detail.addobj?.name}   ${state.detail.addobj?.phone.hidePhoneNumber()}',
                      '${state.detail.addobj?.addressDetail}',
                      idCode: state.detail.addobj?.idcard.hideIdCard(),
                    ),
                    const Custom10SizedboxWidget(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Image(
                                image:
                                    AssetImage('assets/images/shop_icon.png')),
                          ),
                          Text(
                            '${state.detail.from}',
                            style: AppTextStyle.appTextStyle(size: 13.sp),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: state.detail.goods!.first.data!
                          .map((e) => OrderDetailGoodsItemWidget(e))
                          .toList(),
                      // children: List.generate(
                      //     3, (index) => OrderDetailGoodsItemWidget()),
                    ),
                    const Custom10SizedboxWidget(),
                    const OrderDetailPaymentWidget('支付方式', '在线支付'),
                    Column(
                      children: state.detail.payment
                              ?.map((e) =>
                                  OrderDetailPaymentWidget(e.label!, e.value!))
                              .toList() ??
                          [],

                      // children: List.generate(2,
                      //     (index) => OrderDetailPaymentWidget('优惠', '¥1234')),
                    ),
                    OrderDetailTotalPayWidget(state.detail.price!),
                    const Custom10SizedboxWidget(),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '买家留言',
                            style: AppTextStyle.appTextStyle(
                                size: 12.sp, fw: FontWeight.w600),
                          ),
                          Text(
                            state.detail.message!,
                            style: AppTextStyle.appTextStyle(size: 12.sp),
                          )
                        ],
                      ),
                    ),
                    const Custom10SizedboxWidget(),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.06,
                      // color: Colors.amber,
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            flex: 2,
                            child: state.detail.orderstatus == 10
                                ? CountdownTimerWidget(state.detail.payexpire!)
                                : const SizedBox.shrink(),
                          ),
                          Expanded(
                            flex: 1,
                            child: OrderDetailBottomFirstButtonWidget(
                                state.detail.orderstatus!),
                          ),
                          Expanded(
                            flex: 1,
                            child: OrderDetailBottomSecondButtonWidget(
                                state.detail.orderstatus!),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            } else if (state is OrderDetailErrorState) {
              return CustomErrorWidget(state.msg);
            } else {
              return const CustomLoadingCircleWidget();
            }
          },
        ),
      ),
    );
  }
}

class OrderDetailBottomFirstButtonWidget extends StatelessWidget {
  const OrderDetailBottomFirstButtonWidget(
    this.orderStatus, {
    super.key,
  });

  final int orderStatus;
  // final Function() onTap;

  String _getButtonTitle() {
    switch (orderStatus) {
      case 10:
        return '取消订单';
      case 20:
        return '申请退款';
      case 60:
        return '评价';
      default:
        return '';
    }
  }

  Function() _getFunction() {
    Function() onTap = () {};
    switch (orderStatus) {
      case 10:
        onTap = () {
          print('取消订单');
        };
        break;
      case 20:
        onTap = () {
          print('申请退款');
        };
        break;
      case 60:
        onTap = () {
          print('评价');
        };
        break;
    }
    return onTap;
  }

  @override
  Widget build(BuildContext context) {
    return orderStatus != 50
        ? OrderDetailBottomButtonWidget(
            _getButtonTitle(), AppConfig.primaryTextColorBlack, _getFunction())
        : const SizedBox.shrink();
  }
}

class OrderDetailBottomSecondButtonWidget extends StatelessWidget {
  const OrderDetailBottomSecondButtonWidget(
    this.orderStatus, {
    super.key,
  });

  final int orderStatus;

  String _getButtonTitle() {
    switch (orderStatus) {
      case 10:
        return '立即支付';
      case 20:
        return '提醒发货';
      case 50:
        return '删除订单';
      case 60:
        return '再次购买';
      default:
        return '';
    }
  }

  Function() _getFunction() {
    Function() onTap = () {};
    switch (orderStatus) {
      case 10:
        onTap = () {
          print('立即支付');
        };
        break;
      case 20:
        onTap = () {
          print('提醒发货');
        };
        break;
      case 50:
        onTap = () {
          print('删除');
        };
        break;
      case 60:
        onTap = () {
          print('再次购买');
        };
        break;
    }
    return onTap;
  }

  @override
  Widget build(BuildContext context) {
    return OrderDetailBottomButtonWidget(
        _getButtonTitle(), AppConfig.primaryBackgroundColorRed, _getFunction());
  }
}

class OrderDetailBottomButtonWidget extends StatelessWidget {
  const OrderDetailBottomButtonWidget(
    this.title,
    this.fontColor,
    this.onTap, {
    super.key,
  });

  final String title;
  final Color fontColor;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: CustomButtonWidget(
          height: MediaQuery.of(context).size.height * 0.04,
          width: MediaQuery.of(context).size.width * 0.2,
          backgroundColor: AppConfig.primaryWhite,
          fontColor: fontColor,
          fontSize: 12.sp,
          fw: FontWeight.normal,
          border: Border.all(color: AppConfig.secondColorGrey),
          title: title,
          onTap: onTap),
    );
  }
}

class CountdownTimerWidget extends StatefulWidget {
  const CountdownTimerWidget(this.second, {super.key});

  final int second;

  @override
  State<CountdownTimerWidget> createState() => _CountdownTimerWidgetState();
}

class _CountdownTimerWidgetState extends State<CountdownTimerWidget> {
  late Timer _timer;
  // late int _countdownTime = 1200;
  late DateTime endDate = DateTime.now();
  // var hours = 0.0;

  late Duration _countdownDuration;

  void _startTime() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdownDuration.inSeconds < 1) {
          _timer.cancel();
        } else {
          _countdownDuration -= Duration(seconds: 1);
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    // var hoursValue = widget.second / 3600;
    _getDuration();
    // hours = double.parse(hoursValue.toStringAsFixed(2));
    _startTime();
  }

  @override
  void dispose() {
    _timer.cancel();

    super.dispose();
  }

  void _getDuration() {
    int hours = widget.second ~/ 3600;
    int minutes = (widget.second % 3600) ~/ 60;
    int remainingSeconds = widget.second % 60;

    _countdownDuration =
        Duration(hours: hours, minutes: minutes, seconds: remainingSeconds);
  }

  @override
  Widget build(BuildContext context) {
    String hours = _countdownDuration.inHours.toString();
    String minutes = (_countdownDuration.inMinutes % 60).toString();
    String seconds = (_countdownDuration.inSeconds % 60).toString();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            '付款剩余时间:  ',
            style: AppTextStyle.appTextStyle(
                color: AppConfig.secondBackgroundColorGrey, size: 11.sp),
          ),
          Text(
            '$hours:$minutes:$seconds',
            style: AppTextStyle.appTextStyle(
                color: AppConfig.primaryBackgroundColorRed, size: 11.sp),
          ),
        ],
      ),
    );
  }
}

class OrderDetailTotalPayWidget extends StatelessWidget {
  const OrderDetailTotalPayWidget(
    this.total, {
    super.key,
  });

  final String total;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      padding: EdgeInsets.only(right: 8.w),
      // decoration: BoxDecoration(
      //   border: Border(
      //       top: BorderSide(color: AppConfig.primaryBackgroundColorGrey)),
      // ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            '应付款:  ',
            style: AppTextStyle.appTextStyle(fw: FontWeight.w500),
          ),
          Text(
            '¥$total',
            style: AppTextStyle.appTextStyle(
              color: AppConfig.primaryBackgroundColorRed,
            ),
          ),
        ],
      ),
    );
  }
}

class OrderDetailPaymentWidget extends StatelessWidget {
  const OrderDetailPaymentWidget(
    this.title,
    this.value, {
    super.key,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(color: AppConfig.primaryBackgroundColorGrey)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyle.appTextStyle(
                color: AppConfig.secondBackgroundColorGrey, size: 11.sp),
          ),
          Text(
            value,
            style: AppTextStyle.appTextStyle(
                color: AppConfig.secondBackgroundColorGrey, size: 12.sp),
          ),
        ],
      ),
    );
  }
}

class OrderDetailGoodsItemWidget extends StatelessWidget {
  const OrderDetailGoodsItemWidget(
    this.goods, {
    super.key,
  });

  final ApiOrderDetailGoodsData goods;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.12,
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(color: AppConfig.primaryBackgroundColorGrey))),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomCachedNetworkImageWidget(imageUrl: goods.goodsurl!),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.68,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      goods.goodsname!,
                      style: AppTextStyle.appTextStyle(size: 11.sp),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          '¥${goods.unitrefundprice}',
                          style: AppTextStyle.appTextStyle(
                              color: AppConfig.primaryBackgroundColorRed,
                              size: 13.sp),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              '¥${goods.orignprice}',
                              style: TextStyle(
                                  color: AppConfig.secondBackgroundColorGrey,
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 12.sp),
                            ),
                          ),
                        ),
                        Text('x${goods.purchasenum}'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DetailTitleWidget extends StatelessWidget {
  const DetailTitleWidget(
    this.imageName,
    this.titleContent,
    this.endContent, {
    super.key,
    this.idCode,
  });

  final String imageName;
  final String titleContent;
  final String endContent;
  final String? idCode;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.07,
      decoration: BoxDecoration(
          color: AppConfig.primaryWhite,
          border: Border(
              top: BorderSide(
            color: AppConfig.primaryBackgroundColorGrey,
          ))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
              // alignment: Alignment.topCenter,
              padding: EdgeInsets.all(10),
              // color: Colors.amber,
              child: Image(
                  height: MediaQuery.of(context).size.height * 0.02,
                  image: AssetImage(imageName))),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  titleContent,
                  style: AppTextStyle.appTextStyle(size: 12.sp),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  endContent,
                  style: AppTextStyle.appTextStyle(
                      color: AppConfig.secondBackgroundColorGrey, size: 10.sp),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              idCode == null
                  ? SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        idCode ?? '',
                        style: AppTextStyle.appTextStyle(
                            color: AppConfig.secondBackgroundColorGrey,
                            size: 10.sp),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
            ],
          )
        ],
      ),
    );
  }
}
