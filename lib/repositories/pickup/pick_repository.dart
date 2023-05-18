import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:ttmall/models/pickup/pick_address_model.dart';

class PickRepository {
  Future<PickAddressModel> get() async {
    var jsonStr = await rootBundle.loadString('assets/datas/pickAddress.json');
    return PickAddressModel.fromJson(json.decode(jsonStr));
  }
}
