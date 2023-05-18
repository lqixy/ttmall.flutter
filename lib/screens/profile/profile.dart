import 'package:flutter/material.dart';
import 'package:ttmall/utils/app_config.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConfig.primaryWhite,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppConfig.primaryWhite,
        title: Text(
          '我的',
          style: TextStyle(color: AppConfig.primaryTextColorBlack),
        ),
      ),
    );
  }
}
