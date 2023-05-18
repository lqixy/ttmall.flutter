import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:ttmall/models/category/product_brand_model.dart';

class BrandRepository {
  Future<ProductBrandModel> get() async {
    var jsonStr = await rootBundle.loadString('assets/datas/productBrand.json');
    return ProductBrandModel.fromJson(json.decode(jsonStr));
  }
}
