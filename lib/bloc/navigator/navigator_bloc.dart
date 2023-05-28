import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ttmall/utils/route_config.dart';

part 'navigator_event.dart';
part 'navigator_state.dart';

class NavigatorBloc extends Bloc<NavigatorEvent, NavigatorState> {
  NavigatorBloc() : super(NavigatorInitial()) {
    on<NavigatorPushEvent>(
      (event, emit) {
        Navigator.push(
            event.context,
            MaterialPageRoute(
              builder: (context) => event.screenWidget,
            ));
      },
    );

    on<NavigatorPopEvent>(
      (event, emit) {
        Navigator.pop(event.context);
      },
    );

    on<NavigatorPopAndPushNamedEvent>(
      (event, emit) {
        Navigator.popAndPushNamed(event.context, event.routeName);
      },
    );

    on<NavigatorToHomeEvent>(
      (event, emit) {
        Navigator.popUntil(
            event.context, ModalRoute.withName(RouteConfig.Home));
      },
    );

    on<NavigatorPushNamedEvent>(
      (event, emit) {
        Navigator.pushNamed(event.context, event.routeName,
            arguments: event.agruments);
      },
    );
  }
}
