import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ttmall/bloc/dic/dic_bloc.dart';
import 'package:ttmall/shared/custom_button_widget.dart';
import 'package:ttmall/shared/custom_error_widget.dart';
import 'package:ttmall/shared/custom_loading_circle_widget.dart';
import 'package:ttmall/shared/custom_sizedbox_widget.dart';

import '../../../shared/custom_appbar_title_widget.dart';
import '../../../utils/app_config.dart';

class OrderCancelScreen extends StatefulWidget {
  const OrderCancelScreen(this.orderSettlementId, {super.key});
  final String orderSettlementId;
  @override
  State<OrderCancelScreen> createState() => _OrderCancelScreenState();
}

class _OrderCancelScreenState extends State<OrderCancelScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DicBloc>().add(DicLoadEvent(AppDicConfig.orderCancel));
  }

  late String _selectedValue = '';

  void _selectedValueChange(String value) {
    setState(() {
      _selectedValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConfig.primaryWhite,
      appBar: AppBar(
        elevation: 0,
        title: CustomAppBarTitleWidget('取消订单'),
        backgroundColor: AppConfig.primaryWhite,
        foregroundColor: AppConfig.secondBackgroundColorGrey,
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<DicBloc, DicState>(
          builder: (context, state) {
            if (state is DicLoadedState) {
              return Column(
                children: [
                  const Custom10SizedboxWidget(),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 8),
                    height: MediaQuery.of(context).size.height * 0.06,
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: AppConfig.primaryBackgroundColorGrey)),
                    ),
                    child: Text(
                      '请选择取消订单原因',
                      style: AppTextStyle.appTextStyle(
                          color: AppConfig.primaryTextColorBlack,
                          fw: FontWeight.bold,
                          size: 13.sp),
                    ),
                  ),
                  Column(
                    children: state.list
                        .map(
                          (e) => GestureDetector(
                            onTap: () {
                              _selectedValueChange(e.value!);
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.06,
                              decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: AppConfig
                                            .primaryBackgroundColorGrey)),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      e.name!,
                                      style: AppTextStyle.appTextStyle(
                                          color:
                                              AppConfig.primaryTextColorBlack,
                                          size: 12.sp),
                                    ),
                                    Checkbox(
                                        activeColor:
                                            AppConfig.primaryBackgroundColorRed,
                                        shape: CircleBorder(),
                                        value: _selectedValue == e.value,
                                        onChanged: (value) {})
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  Visibility(
                    visible: _selectedValue == '60',
                    child: Padding(
                      padding: EdgeInsets.only(left: 8, top: 8, right: 8),
                      child: Column(
                        children: [
                          TextField(
                            style: AppTextStyle.appTextStyle(
                                color: AppConfig.primaryTextColorBlack,
                                size: 12.sp),
                            cursorColor: AppConfig.primaryTextColorBlack,
                            cursorWidth: 1,
                            maxLines: 3,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(200),
                            ],
                            decoration: InputDecoration(
                              hintText: '请填写取消原因',
                              hintStyle: TextStyle(fontSize: 12.sp),
                              border: InputBorder.none,
                              fillColor: AppConfig.secondColorGrey,
                              filled: true,
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                            // padding: const EdgeInsets.only(left: 8.0, right: 8),
                            child: TextField(
                              readOnly: true,
                              decoration: InputDecoration(
                                fillColor: AppConfig.secondColorGrey,
                                filled: true,
                                border: InputBorder.none,
                                hintText: '最多输入200个字',
                                hintTextDirection: TextDirection.rtl,
                                hintStyle: TextStyle(fontSize: 10.sp),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 8.0,
                        right: 8.0,
                        top: MediaQuery.of(context).size.height * 0.04),
                    child: CustomButtonWidget(
                        height: MediaQuery.of(context).size.height * 0.05,
                        fw: FontWeight.w600,
                        borderRadius: 0,
                        title: '提交',
                        onTap: () {}),
                  ),
                ],
              );
            } else if (state is DicErrorState) {
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
