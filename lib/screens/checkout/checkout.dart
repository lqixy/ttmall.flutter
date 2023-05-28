import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:ttmall/models/orders/api/request/api_order_check_request.dart';
import 'package:ttmall/models/orders/api/request/api_order_submit_request.dart';
import 'package:ttmall/models/orders/order_confirm_model.dart';
import 'package:ttmall/shared/custom_error_widget.dart';
import 'package:ttmall/shared/custom_loading_circle_widget.dart';
import 'package:ttmall/shared/custom_more_popup_button_widget.dart';
import 'package:ttmall/shared/custom_sizedbox_widget.dart';
import 'package:ttmall/shared/dependencies.dart';
import 'package:ttmall/utils/app_config.dart';

import '../../bloc/orders/order_bloc.dart';
import '../../models/orders/api/response/api_order_compute_response.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final input =
        ModalRoute.of(context)?.settings.arguments as ApiOrderSubmitRequest;

    context.read<OrderBloc>().add(OrderCheckEvent(input));
    return Scaffold(
      backgroundColor: AppConfig.primaryBackgroundColorGrey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppConfig.primaryWhite,
        foregroundColor: AppConfig.secondBackgroundColorGrey,
        title: Text(
          '结算台',
          style: AppTextStyle.appTextStyle(
              color: AppConfig.primaryTextColorBlack, size: 14.sp),
        ),
        centerTitle: true,
        actions: [CustomMorePopupButtonWidget(pageIndex: -1)],
      ),
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: BlocBuilder<OrderBloc, OrderState>(
              builder: (context, state) {
                if (state is OrderCheckedState) {
                  return Column(
                    children: [
                      CheckoutDetailWidget(state.model),
                      const Custom5SizedboxWidget(),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.12,
                        color: AppConfig.primaryWhite,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.all(10),
                                  width: MediaQuery.of(context).size.width,
                                  child: Text(
                                    '请选择支付方式:',
                                    style: AppTextStyle.appTextStyle(
                                        color: AppConfig.primaryTextColorBlack,
                                        size: 12.sp),
                                  )),
                            ),
                            Expanded(
                              flex: 1,
                              child: CheckoutPayModeWidget(
                                  'assets/images/alipay.png',
                                  '支付宝',
                                  Icons.chevron_right),
                            )
                          ],
                        ),
                      )
                    ],
                  );
                } else if (state is OrderCheckErrorState) {
                  return CustomErrorWidget(state.msg);
                } else {
                  return const CustomLoadingCircleWidget();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class CheckoutDetailWidget extends StatefulWidget {
  const CheckoutDetailWidget(this.model, {super.key});
  final ApiOrderComputeResponse model;
  @override
  State<CheckoutDetailWidget> createState() => _CheckoutDetailWidgetState();
}

class _CheckoutDetailWidgetState extends State<CheckoutDetailWidget> {
  bool _showMore = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.08,
          decoration: BoxDecoration(
              color: AppConfig.primaryWhite,
              border: Border(
                top: BorderSide(
                  color: AppConfig.primaryBackgroundColorGrey,
                ),
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      '订单总金额: ',
                      style: AppTextStyle.appTextStyle(
                          color: AppConfig.primaryTextColorBlack,
                          fw: FontWeight.w600),
                    ),
                  )),
              Expanded(
                flex: 6,
                child: Text(
                  '¥ ${widget.model.total}',
                  style: AppTextStyle.appTextStyle(
                      color: AppConfig.primaryBackgroundColorRed),
                ),
              ),
              Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _showMore = !_showMore;
                      });
                    },
                    child: Row(
                      children: [
                        Text(
                          '详情',
                          style: AppTextStyle.appTextStyle(
                              color: AppConfig.primaryTextColorBlack,
                              fw: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Icon(
                            _showMore ? Icons.expand_less : Icons.expand_more,
                            color: AppConfig.secondColorGrey,
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
        Visibility(
          visible: _showMore,
          child: Column(
            children: widget.model.detail!
                .map((e) => CheckoutDetailItemWidget(e))
                .toList(),
            // [
            //   CheckoutDetailItemWidget(),
            // ],
          ),
        ),
      ],
    );
  }
}

class CheckoutDetailItemWidget extends StatelessWidget {
  const CheckoutDetailItemWidget(
    this.detail, {
    super.key,
  });

  final ApiOrderComputeDetail detail;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.06,
      decoration: BoxDecoration(
        color: AppConfig.primaryWhite,
        border: Border(
            top: BorderSide(color: AppConfig.primaryBackgroundColorGrey)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${detail.label}',
              style: AppTextStyle.appTextStyle(
                  color: AppConfig.secondTextColorGery, size: 12.sp),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${detail.value}',
              style: AppTextStyle.appTextStyle(
                  color: AppConfig.secondTextColorGery, size: 12.sp),
            ),
          ),
        ],
      ),
    );
  }
}

class CheckoutPayModeWidget extends StatelessWidget {
  const CheckoutPayModeWidget(
    this.imageName,
    this.title,
    this.icon, {
    super.key,
  });

  final String imageName;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(color: AppConfig.primaryBackgroundColorGrey))),
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Image(image: AssetImage(imageName)),
                )),
            Expanded(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(title),
                )),
            Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    icon,
                    color: AppConfig.secondBackgroundColorGrey,
                  ),
                ))
          ],
        ));
  }
}
