import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ttmall/bloc/navigator/navigator_bloc.dart';
import 'package:ttmall/shared/custom_more_popup_button_widget.dart';
import 'package:ttmall/shared/custom_sizedbox_widget.dart';
import 'package:ttmall/utils/app_config.dart';

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
    return Scaffold(
      backgroundColor: AppConfig.primaryBackgroundColorGrey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const ProfileTitleWidget(),
              ProfileMyOrderWidget(),
              const Custom5SizedboxWidget(),
              Column(
                children: bodyTiles
                    .map((e) => ProfileBodyItemWidget(e.imageName, e.title))
                    .toList(),
              ),
              const Custom5SizedboxWidget(),
              Column(
                children: bodyTiles2
                    .map((e) => ProfileBodyItemWidget(e.imageName, e.title))
                    .toList(),
              ),
              const Custom5SizedboxWidget(),
              Column(
                children: bodyTiles3
                    .map((e) => ProfileBodyItemWidget(e.imageName, e.title))
                    .toList(),
              ),
              const Custom5SizedboxWidget(),
              Column(
                children: bodyTiles4
                    .map((e) => ProfileBodyItemWidget(e.imageName, e.title))
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
                        '157****3783 ',
                        style: AppTextStyle.appTextStyle(
                            color: AppConfig.secondTextColorGery, size: 12.sp),
                      ),
                      Text(
                        ' | ',
                        style: AppTextStyle.appTextStyle(
                            color: AppConfig.secondTextColorGery, size: 12.sp),
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
          ),
        ),
      ),
    );
  }
}

class ProfileMyOrderWidget extends StatelessWidget {
  ProfileMyOrderWidget({
    super.key,
  });

  final List<CustomTileModel> tiles = [
    const CustomTileModel('assets/images/pay.png', '待付款'),
    const CustomTileModel('assets/images/send.png', '待发货'),
    const CustomTileModel('assets/images/sended.png', '待收货'),
    const CustomTileModel('assets/images/review.png', '待评价'),
    const CustomTileModel('assets/images/record.png', '退款/售后'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.14,
      color: AppConfig.primaryWhite,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '我的订单',
                  style: AppTextStyle.appTextStyle(
                      size: 14.sp, fw: FontWeight.bold),
                ),
                Text(
                  '全部订单 >',
                  style: AppTextStyle.appTextStyle(
                      color: AppConfig.secondTextColorGery, size: 12.sp),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: tiles
                  .map((e) => ProfileOrderItemWidget(e.imageName, e.title))
                  .toList(),
            ),
          ),
        ],
      ),
    );
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
    this.title, {
    super.key,
  });
  final String imageName;
  final String title;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.06,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image(
              height: MediaQuery.of(context).size.height * 0.03,
              image: AssetImage(imageName)),
          Text(
            title,
            style: AppTextStyle.appTextStyle(
                color: AppConfig.secondTextColorGery, size: 10.sp),
          )
        ],
      ),
    );
  }
}

class ProfileTitleWidget extends StatelessWidget {
  const ProfileTitleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.22,
      width: MediaQuery.of(context).size.width,
      decoration:
          const BoxDecoration(color: AppConfig.primaryBackgroundColorRed),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    BlocProvider.of<NavigatorBloc>(context)
                        .add(NavigatorToHomeEvent(context));
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: AppConfig.primaryWhite,
                  ),
                ),
              ),
              CustomMorePopupButtonWidget(
                pageIndex: 3,
                menuButtonColor: AppConfig.primaryWhite,
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.08,
            child: const CircleAvatar(
              radius: 50,
              backgroundColor: AppConfig.primaryBackgroundColorRed,
              backgroundImage: CachedNetworkImageProvider(
                  'https://timgs-v1.tongtongmall.com/576e3b56-2242-46da-a85d-a882f2f0602b?imageView2/4/quality/30'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Text(
              '155****3783',
              style: AppTextStyle.appTextStyle(
                  color: AppConfig.primaryWhite,
                  size: 14.sp,
                  fw: FontWeight.bold),
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.025,
            width: MediaQuery.of(context).size.width * 0.2,
            decoration: BoxDecoration(
                color: AppConfig.secondColorYellow,
                borderRadius: BorderRadius.circular(14)),
            child: Text(
              '积分: 99',
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
  const CustomTileModel(this.imageName, this.title);
}
