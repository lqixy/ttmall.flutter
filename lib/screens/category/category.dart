import 'package:flutter/material.dart';
import 'package:ttmall/screens/category/widgets/brand_view_widget.dart';
import 'package:ttmall/screens/category/widgets/category_view_widget.dart';
import 'package:ttmall/shared/custom_more_popup_button_widget.dart';
import 'package:ttmall/utils/app_config.dart';
import '../../shared/dependencies.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppConfig.primaryWhite,
        appBar: AppBar(
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Divider(
              color: AppConfig.primaryBackgroundColorGrey,
              height: 1,
              thickness: 1,
            ),
          ),
          backgroundColor: AppConfig.primaryWhite,
          foregroundColor: AppConfig.secondColorGrey,
          actions: [CustomMorePopupButtonWidget(pageIndex: 1)],
          title: const TabBar(
              labelColor: AppConfig.primaryTextColorBlack,
              indicatorColor: AppConfig.primaryBackgroundColorRed,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Tab(
                  text: '分类',
                ),
                Tab(
                  text: '品牌',
                ),
              ]),
        ),
        body: TabBarView(children: [
          Center(
            child: CategoryViewWidget(),
          ),
          BrandViewWidget(),
        ]),
      ),
    );
  }
}
