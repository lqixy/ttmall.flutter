import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:ttmall/models/orders/order_confirm_model.dart';

class OrderConfirmRepository {
  Future<OrderConfirmModel> get() async {
    var jsonStr = await rootBundle.loadString('assets/datas/orderConfirm.json');
    return OrderConfirmModel.fromJson(json.decode(jsonStr));
  }
}
