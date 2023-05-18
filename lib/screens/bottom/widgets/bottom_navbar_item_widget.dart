import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ttmall/utils/app_config.dart';

class NavbarItem extends StatelessWidget {
  NavbarItem(
      {super.key,
      required this.title,
      required this.onTap,
      required this.iconData,
      this.isChecked = false});

  String title;
  Function() onTap;
  IconData iconData;
  bool isChecked;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Expanded(
            child: Icon(
              iconData,
              color: isChecked
                  ? AppConfig.primaryBackgroundColorRed
                  : AppConfig.secondTextColorGery,
            ),
          ),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 10.sp,
                  color: isChecked
                      ? AppConfig.primaryBackgroundColorRed
                      : AppConfig.secondTextColorGery),
            ),
          )
        ],
      ),
    );
  }
}
