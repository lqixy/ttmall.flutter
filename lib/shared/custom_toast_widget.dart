import 'package:flutter/material.dart';

import '../utils/app_config.dart';

class CustomToastWidget extends StatelessWidget {
  const CustomToastWidget(
    this.content, {
    super.key,
  });
  final String content;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppConfig.toastColorBlack,
      ),
      child: Text(
        content,
        style: AppTextStyle.appTextStyle(color: AppConfig.primaryWhite),
      ),
    );
  }
}
