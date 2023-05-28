import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:ttmall/models/cart/api/request/api_cart_add_request.dart';
import 'package:ttmall/models/cart/api/request/api_cart_query_request.dart';
import 'package:ttmall/models/cart/api/request/api_cart_update_request.dart';
import 'package:ttmall/models/cart/api/response/api_cart_count_response.dart';
import 'package:ttmall/models/cart/cart_model.dart';
import 'package:ttmall/utils/app_friendly_exception.dart';
import 'package:ttmall/utils/http_util.dart';

class CartRepository {
  // final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<CartModel> get() async {
    const endpoint = '/user/my-shopping-cart-ver2';

    var response =
        await HttpUtil().getAsync(endpoint, input: ApiCartQueryRequest());
    if (response.success) {
      return CartModel.fromJson(response.data);
    } else {
      throw AppFriendlyException(response.msg ?? '');
    }
  }

  Future<CartModel> update(ApiCartUpdateRequest request) async {
    const endpoint = '/user/shopping-cart-update-ver2';
    var response = await HttpUtil().postAsync(endpoint, request);
    if (response.success) {
      return CartModel.fromJson(response.data);
    } else {
      throw AppFriendlyException(response.msg ?? '');
    }
  }

  Future<ApiCartCountResponse> getCount() async {
    const endpoint = '/user/shoppingcart-count';
    var response = await HttpUtil().getAsync(endpoint);
    return ApiCartCountResponse.fromJson(response.data);
  }

  Future<bool> add(ApiCartAddRequest request) async {
    const endpoint = '/user/shopping-cart-add-ver2';

    var response = await HttpUtil().postAsync(endpoint, request);
    // if (response.success) {}
    if (response.success) {
      return true;
    } else {
      throw AppFriendlyException(response.msg!);
    }
  }
}
