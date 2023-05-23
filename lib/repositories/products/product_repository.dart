import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:ttmall/models/api/api_response.dart';
import 'package:ttmall/models/products/api/api_productinfo_distributioninfo_request.dart';
import 'package:ttmall/models/products/api/api_productinfo_image_request.dart';
import 'package:ttmall/models/products/api/api_productinfo_request.dart';
import 'package:ttmall/models/products/api/api_recommend_goods_request.dart';
import 'package:ttmall/models/products/goods_model.dart';
import 'package:ttmall/models/products/prodetail_comment_model.dart';
import 'package:ttmall/models/products/prodetail_image_model.dart';
import 'package:ttmall/models/products/product_info_model.dart';
import 'package:ttmall/models/products/receipt_service.dart';
import 'package:ttmall/utils/http_util.dart';

class ProductRepository {
  Future<ProductInfoModel> getAsync(String goodsId) async {
    // var jsonStr = await rootBundle.loadString('assets/datas/productInfo.json');
    // return ProductInfoModel.fromJson(json.decode(jsonStr));

    const String endpoint = '/product/product-info-ver2';
    var request = ApiProductInfoRequest(goodsId);
    var response = await HttpUtil().getAsync(endpoint, input: request);
    return ProductInfoModel.fromJson(response.data);
  }

  Future<ReceiptServiceModel> getServices(String goodsId) async {
    const String endpoint = '/product/distributioninfo';
    var request = ApiProductInfoDistributionInfoRequest(goodsId);
    var response = await HttpUtil().postAsync(endpoint, request);

    return ReceiptServiceModel.fromJson(response.data);
  }

  Future<ProductInfoRecommendGoodsModel> getGoods(String goodsId) async {
    const String endpoint = '/product/recommend-goods-goodsdetail';
    var request = ApiRecommendGoodsRequest(goodsId);
    var response = await HttpUtil().getAsync(endpoint, input: request);
    return ProductInfoRecommendGoodsModel.fromJson(response.data);
    // var jsonStr =
    //     await rootBundle.loadString('assets/datas/recommendGoods.json');
    // List<dynamic> jsonMap = json.decode(jsonStr);
    // return jsonMap.map((e) => GoodsModel.fromJson(e)).toList();
  }

  Future<List<ProdetailImageModel>> getProdetailImages(String goodsId) async {
    const String endpoint = '/product/prodetail-img';
    var request = ApiProductInfoImageRequest(goodsId);
    var response = await HttpUtil().getAsync(endpoint, input: request);
    List<dynamic> jsonMap = response.data;
    // var jsonStr =
    //     await rootBundle.loadString('assets/datas/prodetailImages.json');
    // List<dynamic> jsonMap = json.decode(jsonStr);
    return jsonMap.map((e) => ProdetailImageModel.fromJson(e)).toList();
  }

  Future<ApiResponseV2> getResponse(String goodsId) async {
    // var jsonStr = await rootBundle.loadString('assets/datas/productInfo.json');
    // return ProductInfoModel.fromJson(json.decode(jsonStr));

    const String endpoint = '/product/product-info-ver2';
    var request = ApiProductInfoRequest(goodsId);
    var response = await HttpUtil().getAsync(endpoint, input: request);
    return response;
  }

  Future<ApiResponseV2> getServicesResponse(String goodsId) async {
    const String endpoint = '/product/distributioninfo';
    var request = ApiProductInfoDistributionInfoRequest(goodsId);
    return await HttpUtil().postAsync(endpoint, request);

    // return ReceiptServiceModel.fromJson(response.data);
  }

  Future<ApiResponseV2> getGoodsResponse(String goodsId) async {
    const String endpoint = '/product/recommend-goods-goodsdetail';
    var request = ApiRecommendGoodsRequest(goodsId);
    var response = await HttpUtil().getAsync(endpoint, input: request);

    return response;
    // return ProductInfoRecommendGoodsModel.fromJson(response.data);
    // var jsonStr =
    //     await rootBundle.loadString('assets/datas/recommendGoods.json');
    // List<dynamic> jsonMap = json.decode(jsonStr);
    // return jsonMap.map((e) => GoodsModel.fromJson(e)).toList();
  }

  Future<ApiResponseV2> getProdetailImagesResponse(String goodsId) async {
    const String endpoint = '/product/prodetail-img';
    var request = ApiProductInfoImageRequest(goodsId);
    var response = await HttpUtil().getAsync(endpoint, input: request);
    return response;
  }
}
