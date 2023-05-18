import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../utils/app_config.dart';

class CustomLoadingCircleWidget extends StatelessWidget {
  const CustomLoadingCircleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SpinKitFadingCircle(
      color: AppConfig.primaryBackgroundColorRed,
      size: 40.sp,
      // controller: ,
    );
  }
}
