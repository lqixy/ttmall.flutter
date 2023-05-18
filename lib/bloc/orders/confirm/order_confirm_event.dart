part of 'order_confirm_bloc.dart';

abstract class OrderConfirmEvent extends Equatable {
  const OrderConfirmEvent();

  @override
  List<Object> get props => [];
}

class OrderConfirmLoadEvent extends OrderConfirmEvent {}
