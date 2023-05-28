part of 'cart_counter_bloc.dart';

abstract class CartCounterEvent extends Equatable {
  const CartCounterEvent();

  @override
  List<Object> get props => [];
}

class CartCounterLoadEvent extends CartCounterEvent {
  // final int count;
  // const CartCountEvent(this.count);
}
