import 'package:ttmall/screens/cart/widgets/cart_widget.dart';
import 'package:ttmall/shared/dependencies.dart';
import 'package:ttmall/utils/app_config.dart';
import '../../shared/custom_more_popup_button_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: AppConfig.primaryWhite,
        foregroundColor: AppConfig.secondColorGrey,
        title: Text(
          '购物车',
          style: AppTextStyle.appTextStyle(size: 16.sp),
        ),
        elevation: 0,
        centerTitle: true,
        actions: [
          CustomMorePopupButtonWidget(
            pageIndex: 2,
          )
        ],
      ),
      body: SafeArea(child: CartWidget()),
    );
  }
}
