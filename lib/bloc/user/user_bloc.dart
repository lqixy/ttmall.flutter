import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:ttmall/utils/app_friendly_exception.dart';

import '../../models/user/api/response/api_user_center_response.dart';
import '../../repositories/user/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  var repository = GetIt.instance.get<UserRepository>();

  UserBloc() : super(UserInitial()) {
    on<UserCenterLoadEvent>(_userCenterLoad);
  }

  FutureOr<void> _userCenterLoad(
      UserCenterLoadEvent event, Emitter<UserState> emit) async {
    emit(UserCenterLoadingState());
    try {
      var response = await repository.getUserCenter();
      emit(UserCenterLoadedState(response));
    } on AppFriendlyException catch (e) {
      emit(UserCenterErrorState(e.message));
    } catch (e) {
      emit(UserCenterErrorState(e.toString()));
    }
  }
}
