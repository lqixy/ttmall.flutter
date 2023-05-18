import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ttmall/shared/dependencies.dart';
import 'package:ttmall/utils/route_config.dart';

part 'bottom_nav_event.dart';
part 'bottom_nav_state.dart';

class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  BottomNavBloc() : super(BottomNavState(index: 0)) {
    on<BottomNavToPageEvent>(
      (event, emit) {
        var routeName = event.routeName;
        // emit(BottomNavState(index: event.pageIndex));
        if (event.routeName == RouteConfig.Profile) {
          routeName = RouteConfig.Login;
        }
        Navigator.pushNamed(event.context, routeName);
      },
    );
  }
}
