import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_config.dart';
import 'custom_cached_network_image_widget.dart';

class CustomSliderWidget extends StatefulWidget {
  const CustomSliderWidget(
    this.items, {
    super.key,
    this.height,
    this.width,
  });

  final double? height;
  final double? width;
  final List<CustomCachedNetworkImageWidget> items;
  @override
  State<CustomSliderWidget> createState() => _CustomSliderWidgetState();
}

class _CustomSliderWidgetState extends State<CustomSliderWidget> {
  double _index = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) {
      return const SizedBox.shrink();
    } else {
      return SizedBox(
        width: widget.width,
        height: widget.height,
        child: Stack(
          children: [
            CarouselSlider(
              items: widget.items,
              options: CarouselOptions(
                  height: widget.height,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _index = index.toDouble();
                    });
                  },
                  viewportFraction: 1,
                  autoPlay: true),
            ),
            Positioned(
                bottom: 10.h,
                left: 0,
                right: 0,
                child: DotsIndicator(
                  dotsCount: widget.items.length,
                  position: _index,
                  decorator: DotsDecorator(
                      size: const Size.square(9),
                      activeColor: AppConfig.primaryBackgroundColorRed,
                      activeSize: const Size(18, 9),
                      activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                ))
          ],
        ),
      );
    }
  }
}
