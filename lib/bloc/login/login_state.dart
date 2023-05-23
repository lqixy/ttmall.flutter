part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginLoadedState extends LoginState {
  final String token;
  final DateTime? expires;
  const LoginLoadedState(this.token, this.expires);
}

class LoginErrorState extends LoginState {
  final String msg;
  const LoginErrorState(this.msg);
}
