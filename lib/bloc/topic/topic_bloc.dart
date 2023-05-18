import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:ttmall/models/topic/topic_model.dart';
import 'package:ttmall/repositories/topic/topic_repository.dart';
import 'package:ttmall/screens/products/product.dart';

part 'topic_event.dart';
part 'topic_state.dart';

class TopicBloc extends Bloc<TopicEvent, TopicState> {
  final TopicRepository repository = GetIt.instance.get<TopicRepository>();

  TopicBloc() : super(TopicInitial()) {
    on<TopicLoadEvent>(_loadEvent);
    // on<TopicJumpToEvent>(_jumtToEent);
  }

  FutureOr<void> _loadEvent(
      TopicLoadEvent event, Emitter<TopicState> emit) async {
    emit(TopicLoadingState());
    try {
      var result = await repository.get(event.topicCode);
      emit(TopicLoadedState(result));
    } catch (e) {
      emit(TopicErrorState(e.toString()));
    }
  }

  // FutureOr<void> _jumtToEent(
  //     TopicJumpToEvent event, Emitter<TopicState> emit) async {
  //   Navigator.push(
  //       event.context,
  //       MaterialPageRoute(
  //         builder: (context) => ProductScreen(event.goodsId),
  //       ));
  // }
}
