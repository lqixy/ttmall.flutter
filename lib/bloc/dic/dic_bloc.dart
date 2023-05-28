import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:ttmall/models/dic/api_dic_response.dart';
import 'package:ttmall/repositories/dic/dic_repository.dart';
import 'package:ttmall/utils/app_friendly_exception.dart';

part 'dic_event.dart';
part 'dic_state.dart';

class DicBloc extends Bloc<DicEvent, DicState> {
  var repository = GetIt.instance.get<DicRepository>();

  DicBloc() : super(DicInitial()) {
    on<DicLoadEvent>(_loadEvent);
  }

  FutureOr<void> _loadEvent(DicLoadEvent event, Emitter<DicState> emit) async {
    emit(DicLoadingState());
    try {
      var response = await repository.get(event.type);
      emit(DicLoadedState(response));
    } on AppFriendlyException catch (e) {
      emit(DicErrorState(e.message));
    } catch (e) {
      emit(DicErrorState(e.toString()));
    }
  }
}
