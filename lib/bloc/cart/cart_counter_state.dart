part of 'cart_counter_bloc.dart';

abstract class CartCounterState extends Equatable {
  const CartCounterState();

  @override
  List<Object> get props => [];
}

class CartCounterInitial extends CartCounterState {}

class CartCounterLoadingState extends CartCounterState {}

class CartCounterLoadedState extends CartCounterState {
  final int count;
  const CartCounterLoadedState(this.count);
}
