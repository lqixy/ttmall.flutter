import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ttmall/bloc/login/login_bloc.dart';
import 'package:ttmall/bloc/navigator/navigator_bloc.dart';
import 'package:ttmall/screens/login/login_loading.dart';
import 'package:ttmall/screens/login/widgets/login_text_widget.dart';
import 'package:ttmall/screens/login/widgets/login_verified_code_widget.dart';
import 'package:ttmall/shared/custom_toast_widget.dart';
import 'package:ttmall/utils/app_extensions.dart';
import '../../bloc/profile/profile_bloc.dart';
import '../../shared/custom_button_widget.dart';
import '../../shared/custom_textfield_widget.dart';
import '../../utils/app_config.dart';
import '../../utils/route_config.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _mobileController = TextEditingController();
  late final TextEditingController _passwordController =
      TextEditingController();
  late final TextEditingController _codeController = TextEditingController();
  // final ftoast = FToast();
  late bool obscureText = true;
  late bool _showPasswordWidget = false;

  // @override
  // void initState() {
  //   super.initState();
  //   _getDeviceInfo();
  // }

  // Future<void> _getDeviceInfo() async {
  //   var deviceInfo = DeviceInfoPlugin();
  //   if (Theme.of(context).platform == TargetPlatform.android) {
  //     var androidInfo = await deviceInfo.androidInfo;
  //     print(androidInfo.model);
  //   } else if (Theme.of(context).platform == TargetPlatform.iOS) {
  //     var iosInfo = await deviceInfo.iosInfo;
  //     print(iosInfo.model);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppConfig.primaryWhite,
        appBar: AppBar(
          foregroundColor: AppConfig.primaryTextColorBlack,
          elevation: 0,
          backgroundColor: AppConfig.primaryWhite,
          centerTitle: true,
          title: Text(
            '登录',
            style: AppTextStyle.appTextStyle(
                color: AppConfig.primaryTextColorBlack),
          ),
        ),
        body: Column(
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
              '请输入手机号',
              Icons.smartphone_outlined,
              _mobileController,
              textInputType: TextInputType.phone,
            ),
            const Height10SizedBox(),
            Visibility(
              visible: !_showPasswordWidget,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _codeController,
                        decoration: InputDecoration(
                            // border: OutlineInputBorder(),
                            prefixIcon: Icon(
                              Icons.verified_user_outlined,
                            ),
                            hintText: '请输入验证码',
                            hintStyle: TextStyle(
                                color: AppConfig.secondTextColorGery)),
                      ),
                    ),
                    CustomButtonWidget(
                      height: 35.h,
                      width: 100.w,
                      title: '获取验证码',
                      onTap: () {
                        var phoneInput = _mobileController.text;
                        if (!phoneInput.isValidPhoneNumber()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('请输入正确的手机号!')));
                          // ftoast.showToast(
                          //   gravity: ToastGravity.BOTTOM,
                          //   child: CustomToastWidget('请输入正确的手机号!'),
                          // );
                        } else {
                          print(phoneInput);
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
            Visibility(
              visible: _showPasswordWidget,
              child: CustomTextFieldWidget(
                '请输入密码',
                Icons.lock_outline,
                _passwordController,
                obscureText: obscureText,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  child: Icon(
                      obscureText ? Icons.visibility : Icons.visibility_off),
                ),
              ),
            ),
            const Height10SizedBox(),
            Visibility(
              visible: _showPasswordWidget,
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
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginLoadingScreen(
                              _mobileController.text,
                              _passwordController.text,
                              _codeController.text,
                              Platform.isIOS ? 1 : 2),
                        ));
                    // BlocProvider.of<LoginBloc>(context).add(LoginLoadEvent(
                    //     _mobileController.text,
                    //     _passwordController.text,
                    //     _codeController.text,
                    //     Platform.isIOS ? 1 : 0));
                  }),
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
                      content: _showPasswordWidget ? '手机号密码登录' : '短信验证码登录',
                      onTap: () {
                        // print('切换登录方式');
                        // BlocProvider.of<ProfileBloc>(context)
                        //     .add(ProfileHiddenEvent(hidden: !state.isHidden));
                        setState(() {
                          _showPasswordWidget = !_showPasswordWidget;
                        });
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
        ));
  }
}

// class LoginScreen extends StatelessWidget {
//   LoginScreen({super.key});
//   late TextEditingController _mobileController = TextEditingController();
//   late TextEditingController _passwordController = TextEditingController();

//   final ftoast = FToast();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppConfig.primaryWhite,
//       appBar: AppBar(
//         foregroundColor: AppConfig.primaryTextColorBlack,
//         elevation: 0,
//         backgroundColor: AppConfig.primaryWhite,
//         centerTitle: true,
//         title: Text(
//           '登录',
//           style:
//               AppTextStyle.appTextStyle(color: AppConfig.primaryTextColorBlack),
//         ),
//       ),
//       body: BlocBuilder<ProfileBloc, ProfileState>(
//         builder: (context, state) {
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               SizedBox(
//                 height: MediaQuery.of(context).size.height * 0.05,
//               ),
//               Center(
//                 child: Image(
//                     height: MediaQuery.of(context).size.height * 0.1,
//                     image: const CachedNetworkImageProvider(
//                         'https://timgs-v1.tongtongmall.com/8fe9cf3f180646539145cf88d0e066e4?imageView2/4/quality/30')),
//               ),
//               SizedBox(
//                 height: 15.h,
//               ),
//               const Text(
//                 '上通通优品商城，精品好货任你选',
//                 style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
//               ),
//               const Height30SizedBox(),
//               CustomTextFieldWidget(
//                 '请输入手机号',
//                 Icons.smartphone_outlined,
//                 _mobileController,
//                 textInputType: TextInputType.phone,
//               ),
//               const Height10SizedBox(),
//               Offstage(
//                 offstage: !state.isHidden,
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 30.w),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: TextFormField(
//                           decoration: InputDecoration(
//                               // border: OutlineInputBorder(),
//                               prefixIcon: Icon(
//                                 Icons.verified_user_outlined,
//                               ),
//                               hintText: '请输入验证码',
//                               hintStyle: TextStyle(
//                                   color: AppConfig.secondTextColorGery)),
//                         ),
//                       ),
//                       CustomButtonWidget(
//                         height: 35.h,
//                         width: 100.w,
//                         title: '获取验证码',
//                         onTap: () {
//                           var phoneInput = _mobileController.text;
//                           if (!phoneInput.isValidPhoneNumber()) {
//                             ftoast.showToast(
//                               gravity: ToastGravity.CENTER,
//                               child: CustomToastWidget('请输入正确的手机号!'),
//                             );
//                           }
//                           // print(_mobileController.text);
//                           // print('clied 获取验证码');
//                         },
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//               Offstage(
//                 offstage: state.isHidden,
//                 child: CustomTextFieldWidget(
//                   '请输入密码',
//                   Icons.lock_outline,
//                   _passwordController,
//                   obscureText: true,
//                 ),
//               ),
//               const Height10SizedBox(),
//               Offstage(
//                 offstage: state.isHidden,
//                 child: Container(
//                   padding: EdgeInsets.only(right: 20.w),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       LoginTextWidget(
//                           content: '忘记密码?',
//                           fontColor: AppConfig.primaryBackgroundColorRed,
//                           onTap: () {
//                             print('忘记密码');
//                           }),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: MediaQuery.of(context).size.height * 0.05,
//               ),
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 20.w),
//                 child: CustomButtonWidget(
//                     height: MediaQuery.of(context).size.height * 0.08,
//                     width: MediaQuery.of(context).size.width * 0.9,
//                     title: '登录',
//                     fontSize: 18.sp,
//                     borderRadius: 12,
//                     onTap: () {}),
//               ),
//               SizedBox(
//                 height: 20.h,
//               ),
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 20.w),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     LoginTextWidget(
//                         content: state.isHidden ? '手机号密码登录' : '短信验证码登录',
//                         onTap: () {
//                           // print('切换登录方式');
//                           BlocProvider.of<ProfileBloc>(context)
//                               .add(ProfileHiddenEvent(hidden: !state.isHidden));
//                         }),
//                     LoginTextWidget(
//                       content: '新用户注册',
//                       onTap: () {
//                         print('注册');
//                       },
//                     )
//                   ],
//                 ),
//               )
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

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
