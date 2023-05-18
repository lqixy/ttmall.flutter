import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ttmall/screens/topic/topic.dart';

part 'navigator_event.dart';
part 'navigator_state.dart';

class NavigatorBloc extends Bloc<NavigatorEvent, NavigatorState> {
  NavigatorBloc() : super(NavigatorInitial()) {
    on<NavigatorToTopicEvent>(
      (event, emit) {
        Navigator.push(
            event.context,
            MaterialPageRoute(
              builder: (context) => TopicScreen(event.topicCode),
            ));
      },
    );
  }
}
