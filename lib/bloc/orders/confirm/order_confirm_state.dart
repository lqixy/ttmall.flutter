part of 'order_confirm_bloc.dart';

abstract class OrderConfirmState extends Equatable {
  const OrderConfirmState();

  @override
  List<Object> get props => [];
}

class OrderConfirmInitial extends OrderConfirmState {}

class OrderConfirmLoadingState extends OrderConfirmState {}

class OrderConfirmLoadedState extends OrderConfirmState {
  final OrderConfirmModel model;
  const OrderConfirmLoadedState(this.model);
}

class OrderConfirmErrorState extends OrderConfirmState {
  final String msg;
  const OrderConfirmErrorState(this.msg);
}
