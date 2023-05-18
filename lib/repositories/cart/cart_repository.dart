import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:ttmall/models/cart/api/request/api_cart_add_request.dart';
import 'package:ttmall/models/cart/cart_model.dart';
import 'package:ttmall/utils/http_util.dart';

class CartRepository {
  // final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<CartModel> get() async {
    var jsonStr = await rootBundle.loadString('assets/datas/cart.json');
    return CartModel.fromJson(json.decode(jsonStr));
  }

  Future add(ApiCartAddRequest request) async {
    const endpoint = '/user/shopping-cart-add-ver2';
    try {
      var response = await HttpUtil().postAsync(endpoint, request);
      if (response.success) {}
    } catch (e) {
      // print(e.toString());
    }
  }
}
