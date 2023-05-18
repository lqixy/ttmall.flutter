import 'dart:convert';

import 'package:ttmall/models/home/api_request/api_recommend.dart';
import 'package:ttmall/utils/http_util.dart';

import '../../models/recommend/recommend_model.dart';

class RecommendRepository {
  static const String getRecommendEndpoint = '/public/recommend-ver4';

  // Future<List<RecommendModel>> getAsync() async {
  //   var jsonStr = await rootBundle.loadString('assets/datas/recommend.json');
  //   List<dynamic> jsonMap = json.decode(jsonStr);
  //   return jsonMap.map((e) => RecommendModel.fromJson(e)).toList();
  // }

  Future<List<RecommendModel>> getV4({ApiRecommendRequest? request}) async {
    request ??= ApiRecommendRequest();
    var response =
        await HttpUtil().getAsync('/public/recommend-ver4', input: request);
    if (response.success) {
      List<dynamic> jsonMap = response.data;

      return jsonMap.map((e) => RecommendModel.fromJson(e)).toList();
    } else {
      return List.empty();
    }
  }

  Future<RecommendModel> getV2({ApiRecommendRequest? request}) async {
    request ??= ApiRecommendRequest();
    var response =
        await HttpUtil().getAsync('/public/recommend-ver2', input: request);
    if (response.success) {
      // List<dynamic> jsonMap = response.data;
      return RecommendModel.fromJson(response.data);
    } else {
      return RecommendModel();
    }
  }
}
