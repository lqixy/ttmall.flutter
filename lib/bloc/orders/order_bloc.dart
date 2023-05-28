import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ttmall/models/orders/api/request/api_order_compute_request.dart';
import 'package:ttmall/models/orders/api/request/api_order_detail_request.dart';
import 'package:ttmall/models/orders/api/request/api_order_submit_request.dart';
import 'package:ttmall/models/orders/api/response/api_order_compute_response.dart';
import 'package:ttmall/models/orders/order_confirm_model.dart';
import 'package:ttmall/models/user/api/response/api_user_center_response.dart';
import 'package:ttmall/repositories/orders/order_repository.dart';
import 'package:ttmall/utils/app_friendly_exception.dart';

import '../../models/orders/api/request/api_order_list_request.dart';
import '../../models/orders/api/response/api_order_detail_response.dart';
import '../../models/orders/api/response/api_order_list_response.dart';
import '../../repositories/user/user_repository.dart';
import '../../utils/route_config.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  var repository = GetIt.instance.get<OrderRepository>();
  var userRepository = GetIt.instance.get<UserRepository>();

  OrderBloc() : super(OrderInitial()) {
    on<OrderCheckEvent>(_checkEvent);
    on<OrderGotoSubmitPageEvent>(_gotoSubmitPage);

    on<OrderListLoadEvent>(_listLoadEvent);
    on<OrderDetailLoadEvent>(_detailLoadEvent);
  }

  /// 确认订单
  FutureOr<void> _checkEvent(
      OrderCheckEvent event, Emitter<OrderState> emit) async {
    try {
      var submitResponse = await repository.submit(event.request);
      List<ApiOrderComputeItem> orderIds = [];
      for (var element in submitResponse.list!) {
        for (var e in element.list!) {
          orderIds.add(ApiOrderComputeItem(orderid: e.orderid));
        }
      }
      var computeResponse =
          await repository.compute(ApiOrderComputeRequest(list: orderIds));

      emit(OrderCheckedState(computeResponse));
    } on AppFriendlyException catch (e) {
      emit(OrderCheckErrorState(e.message));
    } catch (e) {
      emit(OrderCheckErrorState(e.toString()));
    }
  }

  /// 订单列表
  FutureOr<void> _listLoadEvent(
      OrderListLoadEvent event, Emitter<OrderState> emit) async {
    emit(OrderListLoadingState());
    try {
      var response = await repository.list(event.request);
      var userCenter = await userRepository.getUserCenter();

      emit(OrderListLoadedState(userCenter, response));
    } on AppFriendlyException catch (e) {
      emit(OrderListErrorState(e.message));
    } catch (e) {
      emit(OrderListErrorState(e.toString()));
    }
  }

  /// 跳转到提交订单
  FutureOr<void> _gotoSubmitPage(
      OrderGotoSubmitPageEvent event, Emitter<OrderState> emit) {
    var shops = event.model.shops!
        .map((e) => ApiOrderSubmitShops(shopsid: e.shopsid, msg: e.remark))
        .toList();

    ApiOrderSubmitRequest request = ApiOrderSubmitRequest(
        addr: event.model.address?.addrid,
        shops: shops,
        tk: Platform.isIOS ? '4' : '3');

    Navigator.pushNamed(event.context, RouteConfig.Checkout,
        arguments: request);
  }

  /// 订单详情
  FutureOr<void> _detailLoadEvent(
      OrderDetailLoadEvent event, Emitter<OrderState> emit) async {
    emit(OrderDetailLoadingState());
    try {
      var response = await repository.detail(
          ApiOrderDetailRequest(ordersettlementid: event.ordersettlementid));

      emit(OrderDetailLoadedState(response));
    } on AppFriendlyException catch (e) {
      emit(OrderDetailErrorState(e.message));
    } catch (e) {
      emit(OrderDetailErrorState(e.toString()));
    }
  }
}
