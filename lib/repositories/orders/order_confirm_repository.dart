import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:ttmall/models/orders/api/request/api_order_check_request.dart';
import 'package:ttmall/models/orders/order_confirm_model.dart';
import 'package:ttmall/utils/app_friendly_exception.dart';
import 'package:ttmall/utils/http_util.dart';

class OrderConfirmRepository {
  Future<OrderConfirmModel> get() async {
    // var jsonStr = await rootBundle.loadString('assets/datas/orderConfirm.json');
    // return OrderConfirmModel.fromJson(json.decode(jsonStr));

    var endpoint = '/user/order-check-ver2';
    var input = ApiOrderCheckRequest();
    var response = await HttpUtil().postAsync(endpoint, input);
    if (response.success) {
      return OrderConfirmModel.fromJson(response.data);
    } else {
      throw AppFriendlyException(response.msg!);
    }
  }
}
