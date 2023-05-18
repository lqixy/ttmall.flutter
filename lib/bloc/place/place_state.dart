part of 'place_bloc.dart';

abstract class PlaceState extends Equatable {
  const PlaceState();

  @override
  List<Object> get props => [];
}

class PlaceInitial extends PlaceState {}

class PlaceLoadingState extends PlaceState {}

class PlaceLoadedState extends PlaceState {
  final PlaceModel model;
  const PlaceLoadedState(this.model);
}

class PlaceErrorState extends PlaceState {
  final String msg;
  const PlaceErrorState(this.msg);
}
