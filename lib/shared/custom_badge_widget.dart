import 'package:flutter/material.dart';

class CustomBadgeWidget extends StatelessWidget {
  const CustomBadgeWidget(
    this.count, {
    super.key,
    this.height = 30,
    this.width = 30,
    this.fontSize = 14,
  });

  final int count;
  final double? height;
  final double? width;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return count > 0
        ? Container(
            width: height,
            height: 30,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$count',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
