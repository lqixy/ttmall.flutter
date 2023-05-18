import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ttmall/screens/bottom/widgets/bottom_navbar_item_widget.dart';

import 'package:ttmall/utils/route_config.dart';

import '../../bloc/bottom_nav/bottom_nav_bloc.dart';

class BottomNavbarWidget extends StatelessWidget {
  const BottomNavbarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: BlocBuilder<BottomNavBloc, BottomNavState>(
      builder: (context, state) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              NavbarItem(
                onTap: () {
                  BlocProvider.of<BottomNavBloc>(context).add(
                      BottomNavToPageEvent(
                          context: context, routeName: RouteConfig.Home));
                },
                isChecked: true,
                iconData: Icons.home_outlined,
                title: '首页',
              ),
              NavbarItem(
                onTap: () {
                  BlocProvider.of<BottomNavBloc>(context).add(
                      BottomNavToPageEvent(
                          context: context, routeName: RouteConfig.Category));
                },
                iconData: Icons.manage_search_outlined,
                title: '分类',
              ),
              NavbarItem(
                onTap: () {
                  BlocProvider.of<BottomNavBloc>(context).add(
                      BottomNavToPageEvent(
                          context: context, routeName: RouteConfig.Search));
                },
                // isChecked: state.index == 2,
                iconData: Icons.search_outlined,
                title: '搜索',
              ),
              NavbarItem(
                onTap: () {
                  // BlocProvider.of<BottomNavBloc>(context)
                  //     .add(BottomNavToCartEvent());
                  BlocProvider.of<BottomNavBloc>(context).add(
                      BottomNavToPageEvent(
                          context: context, routeName: RouteConfig.Cart));
                },
                // isChecked: state.index == 3,
                iconData: Icons.shopping_cart_outlined,
                title: '购物车',
              ),
              NavbarItem(
                onTap: () {
                  // BlocProvider.of<BottomNavBloc>(context)
                  //     .add(BottomNavToProfileEvent());
                  BlocProvider.of<BottomNavBloc>(context).add(
                      BottomNavToPageEvent(
                          context: context, routeName: RouteConfig.Profile));
                },
                // isChecked: state.index == 4 || state.index == 5,
                iconData: Icons.person_outline,
                title: '我的',
              ),
              NavbarItem(
                  title: 'demo',
                  onTap: () {
                    BlocProvider.of<BottomNavBloc>(context).add(
                        BottomNavToPageEvent(
                            context: context, routeName: RouteConfig.Demo));
                  },
                  iconData: Icons.more)
            ],
          ),
        );
      },
    ));
  }
}
