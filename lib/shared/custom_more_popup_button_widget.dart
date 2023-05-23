import 'package:ionicons/ionicons.dart';
import 'package:ttmall/bloc/more_popup/more_popup_bloc.dart';
import 'package:ttmall/shared/dependencies.dart';

import '../utils/app_config.dart';

class CustomMorePopupButtonWidget extends StatelessWidget {
  //
  CustomMorePopupButtonWidget(
      {super.key,
      required this.pageIndex,
      this.menuButtonColor = AppConfig.secondColorGrey});

  final List<String> titles = ['首页', '分类', '购物车', '我的'];
  final List<IconData> icons = [
    Ionicons.home_outline,
    Icons.manage_search_outlined,
    Ionicons.cart_outline,
    Ionicons.person_outline,
  ];

  final int pageIndex;
  final Color? menuButtonColor;
  // final void Function(int) onSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      elevation: 0,
      color: menuButtonColor,
      offset: Offset(0, 40.sp),
      // icon: Icon(Ionicons.arrow_down),
      itemBuilder: (context) {
        return List.generate(
            4,
            (index) => PopupMenuItem(
                value: index,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      icons[index],
                      size: 20.sp,
                      color: AppConfig.primaryWhite,
                    ),
                    Text(
                      titles[index],
                      style: AppTextStyle.appTextStyle(
                          color: AppConfig.primaryWhite,
                          size: 16.sp,
                          fw: FontWeight.w100),
                    )
                  ],
                )));
      },
      onSelected: (value) {
        if (value == pageIndex) return;

        var type = MorePopupType.values[value];
        BlocProvider.of<MorePopupBloc>(context)
            .add(MorePopupNavtoEvent(context, type));
      },
    );
  }
}
