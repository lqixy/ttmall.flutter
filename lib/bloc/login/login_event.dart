part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginLoadEvent extends LoginEvent {
  final String mobile;
  final String pwd;
  final String? code;
  final int? tk;
  const LoginLoadEvent(this.mobile, this.pwd, this.code, this.tk);
}
