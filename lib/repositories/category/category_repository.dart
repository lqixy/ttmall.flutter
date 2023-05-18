import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:ttmall/models/category/hot_recommend_model.dart';
import 'package:ttmall/models/category/product_category_model.dart';
import 'package:ttmall/utils/http_util.dart';

import '../../models/api/request/api_request.dart';

class CategoryRepository {
  // Future<ProductCategoryModel> get() async {
  //   var jsonStr =
  //       await rootBundle.loadString('assets/datas/productCategory.json');
  //   return ProductCategoryModel.fromJson(json.decode(jsonStr));
  // }
  Future<ProductCategoryModel> get() async {
    const String endpoint = '/product/product-category';
    var response = await HttpUtil().getAsync(
      endpoint,
    );
    return ProductCategoryModel.fromJson(response.data);
  }

  Future<HotRecommendModel> getHotRecommends() async {
    const String endpoint = '/public/hot-recommend';
    var response = await HttpUtil().getAsync(endpoint);
    // var jsonStr = await rootBundle.loadString('assets/datas/hotRecommend.json');

    return HotRecommendModel.fromJson(response.data);
  }
}
