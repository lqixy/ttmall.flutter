part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  ProfileState({this.isHidden = true});
  bool isHidden;
  @override
  List<Object> get props => [isHidden];
}

// class ProfileInitial extends ProfileState {}
