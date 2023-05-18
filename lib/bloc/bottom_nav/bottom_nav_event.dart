part of 'bottom_nav_bloc.dart';

abstract class BottomNavEvent extends Equatable {
  const BottomNavEvent();

  @override
  List<Object> get props => [];
}

class BottomNavToPageEvent extends BottomNavEvent {
  // int pageIndex;
  final BuildContext context;
  final String routeName;
  const BottomNavToPageEvent({required this.context, required this.routeName});
}

// class BottomNavToHomeEvent extends BottomNavEvent {}

// class BottomNavToCategoryEvent extends BottomNavEvent {}

// class BottomNavToSearchEvent extends BottomNavEvent {}

// class BottomNavToCartEvent extends BottomNavEvent {}

// class BottomNavToProfileEvent extends BottomNavEvent {}
