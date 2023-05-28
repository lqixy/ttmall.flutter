import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:ttmall/models/user/api/response/api_user_center_response.dart';
import 'package:ttmall/models/user/api/response/api_user_info_response.dart';
import 'package:ttmall/repositories/user/user_repository.dart';
import 'package:ttmall/utils/app_friendly_exception.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  var repository = GetIt.instance.get<UserRepository>();

  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileLoadEvent>(_loadEvent);
  }

  FutureOr<void> _loadEvent(
      ProfileLoadEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoadingState());
    try {
      var userInfo = await repository.getUserInfo();
      var userCenter = await repository.getUserCenter();
      emit(ProfileLoadedState(userInfo, userCenter));
    } on AppFriendlyException catch (e) {
      emit(ProfileErrorState(e.message));
    } catch (e) {
      emit(ProfileErrorState(e.toString()));
    }
  }
}
