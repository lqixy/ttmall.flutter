import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ttmall/bloc/navigator/navigator_bloc.dart';
import 'package:ttmall/services/jsp_util.dart';
import 'package:ttmall/shared/dependencies.dart';
import 'package:ttmall/utils/uidata.dart';

import '../../../shared/custom_button_widget.dart';
import '../../../shared/custom_cached_network_image_widget.dart';
import '../../../utils/app_config.dart';

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var authToken = JSpUtil.instance.getString(UIData.authToken);
    var visible = authToken == null || authToken.isEmpty;
    return Column(
      children: [
        Visibility(
          visible: visible,
          child: Container(
            color: AppConfig.primaryWhite,
            child: GestureDetector(
              onTap: () {
                print('购物车点击登录');
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.sp),
                height: 40.h,
                decoration: BoxDecoration(color: AppConfig.primaryColorPink),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '登录后可保存和同步购物车中商品',
                      style: AppTextStyle.appTextStyle(
                          color: AppConfig.primaryBackgroundColorRed,
                          size: 14.sp),
                    ),
                    // CustomButtonWidget(
                    //     height: 24.h, width: 70.w, title: '登录', onTap: () {}),
                    Container(
                      height: 24.h,
                      width: 70.w,
                      decoration: BoxDecoration(
                        color: AppConfig.primaryBackgroundColorRed,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Center(
                        child: Text(
                          '登录',
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: AppConfig.primaryWhite,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Center(
          child: Column(
            children: [
              SizedBox(
                height: 80.h,
              ),
              CustomCachedNetworkImageWidget(
                  height: 100.h,
                  width: 100.w,
                  imageUrl: 'https://timgs-v1.tongtongmall.com/28c263bd'),
              SizedBox(
                height: 20.h,
              ),
              const Text('您的购物车空空如也'),
              SizedBox(
                height: 40.h,
              ),
              CustomButtonWidget(
                  height: 50.h,
                  width: 250.w,
                  title: '去购物',
                  borderRadius: 30,
                  fontSize: 16.sp,
                  onTap: () {
                    // print('去购物喽');
                    BlocProvider.of<NavigatorBloc>(context)
                        .add(NavigatorToHomeEvent(context));
                  }),
            ],
          ),
        ),
      ],
    );
  }
}
