part of 'dic_bloc.dart';

abstract class DicEvent extends Equatable {
  const DicEvent();

  @override
  List<Object> get props => [];
}

class DicLoadEvent extends DicEvent {
  final String type;
  const DicLoadEvent(this.type);
}
