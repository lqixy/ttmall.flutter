part of 'place_bloc.dart';

abstract class PlaceEvent extends Equatable {
  const PlaceEvent();

  @override
  List<Object> get props => [];
}

class PlaceLoadEvent extends PlaceEvent {
  final String title;
  const PlaceLoadEvent(this.title);
}

class PlaceJumpToEvent extends PlaceEvent {
  final BuildContext context;
  final String topicCode;
  const PlaceJumpToEvent(this.context, this.topicCode);
}
