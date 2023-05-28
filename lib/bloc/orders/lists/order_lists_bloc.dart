import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:ttmall/models/orders/api/response/api_order_list_response.dart';
import 'package:ttmall/repositories/orders/order_repository.dart';

import '../../../models/orders/api/request/api_order_list_request.dart';
import '../../../models/user/api/response/api_user_center_response.dart';
import '../../../repositories/user/user_repository.dart';

part 'order_lists_event.dart';
part 'order_lists_state.dart';

class OrderListsBloc extends Bloc<OrderListsEvent, OrderListsState> {
  var repository = GetIt.instance.get<OrderRepository>();
  var userRepository = GetIt.instance.get<UserRepository>();

  OrderListsBloc() : super(OrderListsInitial()) {
    on<OrderListsLoad>(
      _onOrderLoad,
    );
  }

  FutureOr<void> _onOrderLoad(
      OrderListsLoad event, Emitter<OrderListsState> emit) async {
    if (!state.isLoadMore && !event.reload) return;
    try {
      final response = await repository.list(event.request);

      if (event.reload) {
        emit(OrderListsState(
            orders: response.list ?? [],
            isLoadMore: response.list!.isNotEmpty));
      } else {
        emit(response.list!.isEmpty
            ? state.copyWith(isLoadMore: false)
            : state.copyWith(
                orders: List.of(state.orders)..addAll(response.list!),
              ));
      }
    } catch (e) {
      emit(state.copyWith());
    }
  }

  int _getTotalCount(String orderstatus, ApiUserCenterResponse userCenter) {
    var totalCount = 0;

    switch (orderstatus) {
      case '1':
        totalCount = userCenter.allorder ?? 0;
        break;
      case '2':
        totalCount = userCenter.unpaidorder ?? 0;
        break;
      case '3':
        totalCount = userCenter.noreceiveorder ?? 0;
        break;
      case '4':
        totalCount = userCenter.nocommentorder ?? 0;
        break;
      case '5':
        totalCount = userCenter.waitsendorder ?? 0;
        break;
    }
    return totalCount;
  }
}
