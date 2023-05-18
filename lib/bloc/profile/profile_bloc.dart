import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileState()) {
    // on<ProfileEvent>((event, emit) {
    //   // TODO: implement event handler
    // });
    on<ProfileHiddenEvent>(_profileHiddenEvent);
  }

  void _profileHiddenEvent(ProfileHiddenEvent event, Emitter emit) {
    emit(ProfileState(isHidden: event.hidden));
  }
}
