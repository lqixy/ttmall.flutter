import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ttmall/bloc/navigator/navigator_bloc.dart';
import 'package:ttmall/models/user/api/response/api_user_center_response.dart';
import 'package:ttmall/models/user/api/response/api_user_info_response.dart';
import 'package:ttmall/screens/orders/detail/order_detail.dart';
import 'package:ttmall/screens/orders/lists/order_lists.dart';
import 'package:ttmall/shared/custom_badge_widget.dart';
import 'package:ttmall/shared/custom_error_widget.dart';
import 'package:ttmall/shared/custom_loading_circle_widget.dart';
import 'package:ttmall/shared/custom_more_popup_button_widget.dart';
import 'package:ttmall/shared/custom_sizedbox_widget.dart';
import 'package:ttmall/utils/app_config.dart';
import 'package:ttmall/utils/app_extensions.dart';
import 'package:ttmall/utils/route_config.dart';

import '../../bloc/profile/profile_bloc.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  // final List<CustomTileModel> bodyTiles = [
  //   const CustomTileModel('assets/images/group.png', '拼团订单'),
  //   const CustomTileModel('assets/images/coupon.png', '我的优惠券'),
  //   const CustomTileModel('assets/images/heard.png', '我的关注'),
  //   const CustomTileModel('assets/images/address.png', '收货地址'),
  //   const CustomTileModel('assets/images/store.png', '线下网点'),
  //   const CustomTileModel('assets/images/user_add.png', '用户邀请'),
  //   const CustomTileModel('assets/images/rebate.png', '返佣账户'),
  //   const CustomTileModel('assets/images/mic.png', '联系客服'),
  //   const CustomTileModel('assets/images/help.png', '使用帮助'),
  // ];

  final List<CustomTileModel> bodyTiles = [
    const CustomTileModel('assets/images/group.png', '拼团订单'),
    const CustomTileModel('assets/images/coupon.png', '我的优惠券'),
    const CustomTileModel('assets/images/heard.png', '我的关注'),
  ];
  final List<CustomTileModel> bodyTiles2 = [
    const CustomTileModel('assets/images/address.png', '收货地址'),
    const CustomTileModel('assets/images/store.png', '线下网点'),
  ];
  final List<CustomTileModel> bodyTiles3 = [
    const CustomTileModel('assets/images/user_add.png', '用户邀请'),
    const CustomTileModel('assets/images/rebate.png', '返佣账户'),
  ];
  final List<CustomTileModel> bodyTiles4 = [
    const CustomTileModel('assets/images/mic.png', '联系客服'),
    const CustomTileModel('assets/images/help.png', '使用帮助'),
  ];

  @override
  Widget build(BuildContext context) {
    context.read<ProfileBloc>().add(ProfileLoadEvent());
    return Scaffold(
      backgroundColor: AppConfig.primaryBackgroundColorGrey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoadedState) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ProfileTitleWidget(state.userInfo),
                    ProfileMyOrderWidget(state.userCenter),
                    const Custom5SizedboxWidget(),
                    Column(
                      children: bodyTiles
                          .map((e) =>
                              ProfileBodyItemWidget(e.imageName, e.title))
                          .toList(),
                    ),
                    const Custom5SizedboxWidget(),
                    Column(
                      children: bodyTiles2
                          .map((e) =>
                              ProfileBodyItemWidget(e.imageName, e.title))
                          .toList(),
                    ),
                    const Custom5SizedboxWidget(),
                    Column(
                      children: bodyTiles3
                          .map((e) =>
                              ProfileBodyItemWidget(e.imageName, e.title))
                          .toList(),
                    ),
                    const Custom5SizedboxWidget(),
                    Column(
                      children: bodyTiles4
                          .map((e) =>
                              ProfileBodyItemWidget(e.imageName, e.title))
                          .toList(),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: AppConfig.primaryBackgroundColorGrey,
                          border: const Border(
                            bottom: BorderSide(
                                color: AppConfig.secondColorGrey, width: 0.5),
                          )),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              state.userInfo.phone!,
                              style: AppTextStyle.appTextStyle(
                                  color: AppConfig.secondTextColorGery,
                                  size: 12.sp),
                            ),
                            Text(
                              ' | ',
                              style: AppTextStyle.appTextStyle(
                                  color: AppConfig.secondTextColorGery,
                                  size: 12.sp),
                            ),
                            GestureDetector(
                                onTap: () {
                                  print('退出');
                                },
                                child: Text(
                                  ' 退出',
                                  style: AppTextStyle.appTextStyle(
                                      color: AppConfig.secondTextColorGery,
                                      size: 12.sp),
                                )),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: const Border(
                            bottom: BorderSide(
                                width: 0.5, color: AppConfig.secondColorGrey)),
                        color: AppConfig.primaryBackgroundColorGrey,
                      ),
                      child: Text(
                        '© 2016 河南通通优品科技有限公司. 版权所有 备案号： 豫B2-20160127-1',
                        style: AppTextStyle.appTextStyle(
                            size: 12.sp, color: AppConfig.secondTextColorGery),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                );
              } else if (state is ProfileErrorState) {
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

class ProfileMyOrderWidget extends StatelessWidget {
  ProfileMyOrderWidget(
    this.userCenter, {
    super.key,
  });

  final ApiUserCenterResponse userCenter;

  final List<CustomTileModel> tiles = [
    const CustomTileModel('assets/images/pay.png', '待付款',
        titleName: 'unpaidorder', orderType: 2),
    const CustomTileModel('assets/images/send.png', '待发货',
        titleName: 'waitsendorder', orderType: 5),
    const CustomTileModel('assets/images/sended.png', '待收货',
        titleName: 'noreceiveorder', orderType: 3),
    const CustomTileModel('assets/images/review.png', '待评价',
        titleName: 'nocommentorder', orderType: 4),
    const CustomTileModel('assets/images/record.png', '退款/售后',
        titleName: 'refundorder', orderType: -1),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      color: AppConfig.primaryWhite,
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '我的订单',
                    style: AppTextStyle.appTextStyle(
                        size: 12.sp, fw: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      BlocProvider.of<NavigatorBloc>(context).add(
                          NavigatorPushEvent(context, OrderListsScreen(1)));
                    },
                    child: Text(
                      '全部订单 >',
                      style: AppTextStyle.appTextStyle(
                          color: AppConfig.secondTextColorGery, size: 12.sp),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: tiles.map((e) {
                return GestureDetector(
                  onTap: () {
                    if (e.orderType != -1) {
                      BlocProvider.of<NavigatorBloc>(context).add(
                          NavigatorPushEvent(
                              context, OrderListsScreen(e.orderType)));
                    } else {}
                  },
                  child: ProfileOrderItemWidget(
                      e.imageName, e.title, _getBadgeCount(e.titleName!)),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  int _getBadgeCount(String title) {
    var count = 0;
    switch (title) {
      case 'unpaidorder':
        count = userCenter.unpaidorder!;
        break;
      case 'waitsendorder':
        count = userCenter.waitsendorder!;
        break;
      case 'noreceiveorder':
        count = userCenter.noreceiveorder!;
        break;
      case 'nocommentorder':
        count = userCenter.nocommentorder!;
        break;
      case 'refundorder':
        count = userCenter.refundorder!;
        break;
    }
    return count;
  }
}

class ProfileBodyItemWidget extends StatelessWidget {
  const ProfileBodyItemWidget(
    this.imageName,
    this.title, {
    super.key,
  });

  final String imageName;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.08,
      color: AppConfig.primaryWhite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image(
              height: MediaQuery.of(context).size.height * 0.026,
              image: AssetImage(imageName)),
          Container(
              height: MediaQuery.of(context).size.height * 0.05,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: AppConfig.primaryBackgroundColorGrey))),
              width: MediaQuery.of(context).size.width * 0.86,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: AppTextStyle.appTextStyle(
                        color: AppConfig.primaryTextColorBlack),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: AppConfig.secondColorGrey,
                    size: 16.sp,
                  )
                ],
              ))
        ],
      ),
    );
  }
}

class ProfileOrderItemWidget extends StatelessWidget {
  const ProfileOrderItemWidget(
    this.imageName,
    this.title,
    this.count, {
    super.key,
  });
  final String imageName;
  final String title;
  final int count;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Stack(
            children: [
              Image(
                  height: MediaQuery.of(context).size.height * 0.04,
                  width: MediaQuery.of(context).size.width * 0.1,
                  image: AssetImage(imageName)),
              Positioned(
                top: -8,
                right: 0,
                child: count > 0
                    ? CustomBadgeWidget(
                        count,
                        width: 15.w,
                        height: 15.h,
                        fontSize: 10.sp,
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
        Expanded(
          child: Text(
            title,
            style: AppTextStyle.appTextStyle(
                color: AppConfig.secondTextColorGery, size: 10.sp),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}

class ProfileTitleWidget extends StatelessWidget {
  const ProfileTitleWidget(
    this.userInfo, {
    super.key,
  });

  final ApiUserInfoResponse userInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width,
      decoration:
          const BoxDecoration(color: AppConfig.primaryBackgroundColorRed),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<NavigatorBloc>(context)
                        .add(NavigatorToHomeEvent(context));
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: AppConfig.primaryWhite,
                  ),
                ),
                // CustomMorePopupButtonWidget(
                //   pageIndex: 3,
                //   menuButtonColor: AppConfig.primaryWhite,
                // ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.08,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: AppConfig.primaryBackgroundColorRed,
              backgroundImage: CachedNetworkImageProvider(userInfo.headimg!),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Text(
              userInfo.phone!,
              style: AppTextStyle.appTextStyle(
                  color: AppConfig.primaryWhite,
                  size: 14.sp,
                  fw: FontWeight.bold),
            ),
          ),
          Container(
            alignment: Alignment.center,
            // height: MediaQuery.of(context).size.height * 0.025,
            width: MediaQuery.of(context).size.width * 0.2,
            margin: EdgeInsets.only(bottom: 8.0),
            decoration: BoxDecoration(
                color: AppConfig.secondColorYellow,
                borderRadius: BorderRadius.circular(14)),
            child: Text(
              '积分: ${userInfo.scores}',
              style: AppTextStyle.appTextStyle(
                  color: AppConfig.primaryWhite, size: 12.sp),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTileModel {
  final String imageName;
  final String title;
  final String? titleName;
  final int orderType;
  const CustomTileModel(this.imageName, this.title,
      {this.titleName, this.orderType = 1});
}
