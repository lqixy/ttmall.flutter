import 'package:ttmall/screens/cart/widgets/cart_widget.dart';
import 'package:ttmall/screens/cart/widgets/empty_cart_widget.dart';
import 'package:ttmall/shared/dependencies.dart';
import 'package:ttmall/utils/app_config.dart';
import '../../bloc/cart/cart_bloc.dart';
import '../../bloc/cart/cart_counter_bloc.dart';
import '../../shared/custom_error_widget.dart';
import '../../shared/custom_loading_circle_widget.dart';
import '../../shared/custom_more_popup_button_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // context.read<CartBloc>().add(CartLoadEvent());
    context.read<CartCounterBloc>().add(CartCounterLoadEvent());
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: AppConfig.primaryWhite,
        foregroundColor: AppConfig.secondColorGrey,
        title: BlocBuilder<CartCounterBloc, CartCounterState>(
          builder: (context, state) {
            if (state is CartCounterLoadedState) {
              return Text(
                '购物车(${state.count})',
                style: AppTextStyle.appTextStyle(size: 16.sp),
              );
            } else {
              return Text(
                '购物车',
                style: AppTextStyle.appTextStyle(size: 16.sp),
              );
            }
          },
        ),
        elevation: 0,
        centerTitle: true,
        actions: [
          CustomMorePopupButtonWidget(
            pageIndex: 2,
          )
        ],
      ),
      body: SafeArea(child: BlocBuilder<CartCounterBloc, CartCounterState>(
        builder: (context, state) {
          if (state is CartCounterLoadedState) {
            if (state.count > 0) {
              return CartWidget();
            } else {
              return const EmptyCartWidget();
            }
          } else {
            return const CustomLoadingCircleWidget();
          }
          // return CartWidget();
        },
      )),
    );
  }
}
