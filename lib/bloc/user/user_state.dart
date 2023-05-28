part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserCenterLoadingState extends UserState {}

class UserCenterLoadedState extends UserState {
  final ApiUserCenterResponse userCenter;
  const UserCenterLoadedState(this.userCenter);
}

class UserCenterErrorState extends UserState {
  final String msg;
  const UserCenterErrorState(this.msg);
}
