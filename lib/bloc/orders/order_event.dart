part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class OrderCheckEvent extends OrderEvent {
  final ApiOrderSubmitRequest request;
  const OrderCheckEvent(this.request);
}

class OrderGotoSubmitPageEvent extends OrderEvent {
  final BuildContext context;
  // final ApiOrderSubmitRequest request;
  final OrderConfirmModel model;
  // final String? remark;
  const OrderGotoSubmitPageEvent(
    this.context,
    this.model,
  );
}

class OrderListLoadEvent extends OrderEvent {
  final ApiOrderListRequest request;
  const OrderListLoadEvent(this.request);
}

class OrderDetailLoadEvent extends OrderEvent {
  final String ordersettlementid;
  const OrderDetailLoadEvent(this.ordersettlementid);
}
