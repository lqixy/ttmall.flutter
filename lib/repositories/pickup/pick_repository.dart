import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:ttmall/models/pickup/pick_address_model.dart';
import 'package:ttmall/utils/app_friendly_exception.dart';
import 'package:ttmall/utils/http_util.dart';

class PickRepository {
  Future<PickAddressModel> get() async {
    // var jsonStr = await rootBundle.loadString('assets/datas/pickAddress.json');
    // return PickAddressModel.fromJson(json.decode(jsonStr));
    var endpoint = '/public/pickaddress';
    var response = await HttpUtil().getAsync(endpoint);
    if (response.success) {
      return PickAddressModel.fromJson(response.data);
    } else {
      throw AppFriendlyException(response.msg!);
    }
  }
}
