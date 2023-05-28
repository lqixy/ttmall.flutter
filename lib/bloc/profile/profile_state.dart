part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  final ApiUserInfoResponse userInfo;
  final ApiUserCenterResponse userCenter;
  const ProfileLoadedState(this.userInfo, this.userCenter);
}

class ProfileErrorState extends ProfileState {
  final String msg;
  const ProfileErrorState(this.msg);
}
