part of 'order_lists_bloc.dart';

enum OrderListsStatus { initial, success, failure }

class OrderListsState extends Equatable {
  // final OrderListsStatus status;
  final List<ApiOrderListItem> orders;
  final bool isLoadMore;
  const OrderListsState(
      {
      // this.status = OrderListsStatus.initial,
      this.orders = const [],
      this.isLoadMore = true});

  OrderListsState copyWith({
    // OrderListsStatus? status,
    List<ApiOrderListItem>? orders,
    bool? isLoadMore,
  }) {
    return OrderListsState(
        // status: status ?? this.status,
        orders: orders ?? this.orders,
        isLoadMore: isLoadMore ?? this.isLoadMore);
  }

  @override
  List<Object> get props => [
        // status,
        orders,
        // isLoadMore
      ];
}
// class OrderListsState extends Equatable {
//   final OrderListsStatus status;
//   final List<ApiOrderListItem> orders;
//   final bool isLoadMore;
//   const OrderListsState(
//       {this.status = OrderListsStatus.initial,
//       this.orders = const [],
//       this.isLoadMore = true});

//   OrderListsState copyWith({
//     OrderListsStatus? status,
//     List<ApiOrderListItem>? orders,
//     bool? isLoadMore,
//   }) {
//     return OrderListsState(
//         status: status ?? this.status,
//         orders: orders ?? this.orders,
//         isLoadMore: isLoadMore ?? this.isLoadMore);
//   }

//   @override
//   List<Object> get props => [status, orders, isLoadMore];
// }

class OrderListsInitial extends OrderListsState {}
