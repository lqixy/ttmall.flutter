import 'package:flutter/material.dart';

import '../../../utils/app_config.dart';

class PlaceItemTitleWidget extends StatelessWidget {
  const PlaceItemTitleWidget(
    this.title, {
    super.key,
    this.backgroundColor,
  });
  final String title;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: backgroundColor,
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Image(image: AssetImage('assets/images/place_title.png')),
          ),
          Text(
            title,
            style: AppTextStyle.appTextStyle(fw: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
