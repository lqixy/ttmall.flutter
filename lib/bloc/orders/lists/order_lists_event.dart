part of 'order_lists_bloc.dart';

abstract class OrderListsEvent extends Equatable {
  const OrderListsEvent();

  @override
  List<Object> get props => [];
}

class OrderListsLoad extends OrderListsEvent {
  final ApiOrderListRequest request;
  final bool reload;
  // final int oldIndex;
  // final int totalCount;
  const OrderListsLoad(this.request, {this.reload = false});
}
