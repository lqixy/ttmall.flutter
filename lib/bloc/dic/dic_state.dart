part of 'dic_bloc.dart';

abstract class DicState extends Equatable {
  const DicState();

  @override
  List<Object> get props => [];
}

class DicInitial extends DicState {}

class DicLoadingState extends DicState {}

class DicLoadedState extends DicState {
  final List<ApiDicResponse> list;
  const DicLoadedState(this.list);
}

class DicErrorState extends DicState {
  final String msg;
  const DicErrorState(this.msg);
}
