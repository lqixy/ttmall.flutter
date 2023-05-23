import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ttmall/services/jsp_util.dart';
import 'package:ttmall/shared/dependencies.dart';
import 'package:ttmall/utils/route_config.dart';
import 'package:ttmall/utils/uidata.dart';

part 'bottom_nav_event.dart';
part 'bottom_nav_state.dart';

class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  BottomNavBloc() : super(BottomNavState(index: 0)) {
    on<BottomNavToPageEvent>(
      (event, emit) {
        var routeName = event.routeName;
        // emit(BottomNavState(index: event.pageIndex));
        if (event.routeName == RouteConfig.Profile) {
          var authToken = JSpUtil.instance.getString(UIData.authToken);
          if (authToken != null && authToken!.isNotEmpty) {
            routeName = RouteConfig.Profile;
          } else {
            routeName = RouteConfig.Login;
          }
        }
        Navigator.pushNamed(event.context, routeName);
      },
    );
  }
}
