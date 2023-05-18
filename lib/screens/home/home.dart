import 'package:flutter/material.dart';

import 'package:ttmall/screens/home/widgets/home_menu_widget.dart';
import 'package:ttmall/screens/home/widgets/home_notices_widget.dart';
import 'package:ttmall/screens/home/widgets/home_product_widget.dart';

import 'package:ttmall/screens/home/widgets/slider_widget.dart';
import 'package:ttmall/shared/custom_sizedbox_widget.dart';

import '../../utils/app_config.dart';
import '../bottom/bottom_navbar_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: MyAppBar(),
      backgroundColor: AppConfig.primaryWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: const [
              HomeSliderWidget(),
              HomeMenuWidget(),
              Custom10SizedboxWidget(),
              HomeNoticesWidget(),
              Custom10SizedboxWidget(),
              HomeProductWidget(),
              Custom10SizedboxWidget(),
              // RecommentProductWidget()
            ],
          ),
        ),
      ),

      bottomNavigationBar: const BottomNavbarWidget(),
    );
  }
}
