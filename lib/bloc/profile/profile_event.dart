part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileHiddenEvent extends ProfileEvent {
  bool hidden;

  ProfileHiddenEvent({this.hidden = true});
}
