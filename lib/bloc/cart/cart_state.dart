part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoadingState extends CartState {}

class CartLoadedState extends CartState {
  final CartModel model;
  const CartLoadedState(this.model);
}

class CartErrorState extends CartState {
  final String msg;
  const CartErrorState(this.msg);
}
