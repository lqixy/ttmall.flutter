import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ttmall/shared/custom_loading_circle_widget.dart';

import '../utils/app_config.dart';

class CustomCachedNetworkImageWidget extends StatelessWidget {
  const CustomCachedNetworkImageWidget(
      {super.key,
      required this.imageUrl,
      this.height,
      this.width,
      this.fit = BoxFit.fill});
  final String imageUrl;
  final double? height;
  final double? width;
  final BoxFit? fit;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: fit,
      height: height,
      width: width,
      imageUrl: imageUrl,
      placeholder: (context, url) => const CustomLoadingCircleWidget(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}

class CustomCachedNetworkBorderImageWidget extends StatelessWidget {
  const CustomCachedNetworkBorderImageWidget(
      {super.key,
      required this.imageUrl,
      this.border,
      // this.height,
      // this.width,

      this.fit = BoxFit.fill});
  final String imageUrl;
//  final double? height;
//  final double? width;
  final BoxFit? fit;
  final BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: border,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image(
            image: imageProvider,
            fit: fit,
          ),
        ),
      ),
    );
  }
}
