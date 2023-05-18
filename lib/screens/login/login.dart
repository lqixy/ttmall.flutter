import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ttmall/screens/login/widgets/login_text_widget.dart';
import 'package:ttmall/screens/login/widgets/login_verified_code_widget.dart';
import '../../bloc/profile/profile_bloc.dart';
import '../../shared/custom_button_widget.dart';
import '../../shared/custom_textfield_widget.dart';
import '../../utils/app_config.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConfig.primaryWhite,
      appBar: AppBar(
        foregroundColor: AppConfig.primaryTextColorBlack,
        elevation: 0,
        backgroundColor: AppConfig.primaryWhite,
        centerTitle: true,
        title: Text(
          '登录',
          style:
              AppTextStyle.appTextStyle(color: AppConfig.primaryTextColorBlack),
        ),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Center(
                child: Image(
                    height: MediaQuery.of(context).size.height * 0.1,
                    image: const CachedNetworkImageProvider(
                        'https://timgs-v1.tongtongmall.com/8fe9cf3f180646539145cf88d0e066e4?imageView2/4/quality/30')),
              ),
              SizedBox(
                height: 15.h,
              ),
              const Text(
                '上通通优品商城，精品好货任你选',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
              const Height30SizedBox(),
              CustomTextFieldWidget(
                hintText: '请输入手机号',
                iconData: Icons.smartphone_outlined,
              ),
              const Height10SizedBox(),
              Offstage(
                  offstage: !state.isHidden,
                  child: const LoginVerifiedCodeWidget()),
              Offstage(
                offstage: state.isHidden,
                child: CustomTextFieldWidget(
                    obscureText: true,
                    hintText: '请输入密码',
                    iconData: Icons.lock_outline),
              ),
              const Height10SizedBox(),
              Offstage(
                offstage: state.isHidden,
                child: Container(
                  padding: EdgeInsets.only(right: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      LoginTextWidget(
                          content: '忘记密码?',
                          fontColor: AppConfig.primaryBackgroundColorRed,
                          onTap: () {
                            print('忘记密码');
                          }),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: CustomButtonWidget(
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width * 0.9,
                    title: '登录',
                    fontSize: 18.sp,
                    borderRadius: 12,
                    onTap: () {}),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LoginTextWidget(
                        content: state.isHidden ? '手机号密码登录' : '短信验证码登录',
                        onTap: () {
                          // print('切换登录方式');
                          BlocProvider.of<ProfileBloc>(context)
                              .add(ProfileHiddenEvent(hidden: !state.isHidden));
                        }),
                    LoginTextWidget(
                      content: '新用户注册',
                      onTap: () {
                        print('注册');
                      },
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class Height30SizedBox extends StatelessWidget {
  const Height30SizedBox({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.h,
    );
  }
}

class Height10SizedBox extends StatelessWidget {
  const Height10SizedBox({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10.h,
    );
  }
}
