part of 'bottom_nav_bloc.dart';

class BottomNavState extends Equatable {
  BottomNavState({required this.index, this.isLogin = false});
  int index;
  bool isLogin;
  @override
  List<Object> get props => [index, isLogin];
}

// class BottomNavInitial extends BottomNavState {}
