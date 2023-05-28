part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class OrderCheckState extends OrderState {}

class OrderCheckErrorState extends OrderState {
  final String msg;
  const OrderCheckErrorState(this.msg);
}

class OrderCheckedState extends OrderState {
  final ApiOrderComputeResponse model;
  const OrderCheckedState(this.model);
}

class OrderListLoadingState extends OrderState {}

class OrderListLoadedState extends OrderState {
  final ApiUserCenterResponse userCenter;
  final ApiOrderListResponse orders;
  const OrderListLoadedState(this.userCenter, this.orders);
}

class OrderListErrorState extends OrderState {
  final String msg;
  const OrderListErrorState(this.msg);
}

class OrderDetailLoadingState extends OrderState {}

class OrderDetailLoadedState extends OrderState {
  final ApiOrderDetailResponse detail;
  const OrderDetailLoadedState(this.detail);
}

class OrderDetailErrorState extends OrderState {
  final String msg;
  const OrderDetailErrorState(this.msg);
}
