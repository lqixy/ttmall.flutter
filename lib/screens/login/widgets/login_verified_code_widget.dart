import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/custom_button_widget.dart';
import '../../../utils/app_config.dart';

class LoginVerifiedCodeWidget extends StatelessWidget {
  const LoginVerifiedCodeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                  // border: OutlineInputBorder(),
                  prefixIcon: Icon(
                    Icons.verified_user_outlined,
                  ),
                  hintText: '请输入验证码',
                  hintStyle: TextStyle(color: AppConfig.secondTextColorGery)),
            ),
          ),
          CustomButtonWidget(
            height: 35.h,
            width: 100.w,
            title: '获取验证码',
            onTap: () {
              // print('clied 获取验证码');
            },
          )
        ],
      ),
    );
  }
}
