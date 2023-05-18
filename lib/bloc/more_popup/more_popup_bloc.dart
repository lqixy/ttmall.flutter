import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ttmall/main.dart';
import 'package:ttmall/screens/cart/cart.dart';
import 'package:ttmall/screens/category/category.dart';
import 'package:ttmall/screens/home/home.dart';
import 'package:ttmall/screens/profile/profile.dart';
import 'package:ttmall/shared/dependencies.dart';
import 'package:ttmall/utils/route_config.dart';

part 'more_popup_event.dart';
part 'more_popup_state.dart';

class MorePopupBloc extends Bloc<MorePopupEvent, MorePopupState> {
  MorePopupBloc() : super(MorePopupInitial()) {
    on<MorePopupNavtoEvent>(_morePopupNavtoEvent);
  }

  void _morePopupNavtoEvent(
      MorePopupNavtoEvent event, Emitter<MorePopupState> emit) {
    switch (event.type) {
      case MorePopupType.indexPage:
        Navigator.popUntil(
            event.context, ModalRoute.withName(RouteConfig.Home));
        break;
      case MorePopupType.category:
        _navToPage(event.context, RouteConfig.Category);
        break;
      case MorePopupType.cart:
        _navToPage(event.context, RouteConfig.Cart);
        break;
      case MorePopupType.profile:
        _navToPage(event.context, RouteConfig.Profile);
        break;
    }
  }

  void _navToPage(BuildContext context, String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
  }
}
