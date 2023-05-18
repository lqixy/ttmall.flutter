part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeLoadEvent extends HomeEvent {}

class HomeNavToPlaceEvent extends HomeEvent {
  final String placeName;
  final BuildContext context;

  const HomeNavToPlaceEvent(this.context, this.placeName);
}

// class HomeNavToProductEvent extends HomeEvent {
//   final BuildContext context;
//   final String id;
//   const HomeNavToProductEvent(this.context, this.id);
// }
