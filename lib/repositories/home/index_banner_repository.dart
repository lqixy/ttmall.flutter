import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:ttmall/models/home/api_request/apii_indexbanner_request.dart';
import 'package:ttmall/models/home/index_banner_model.dart';
import 'package:ttmall/utils/http_util.dart';

class IndexBannerRepository {
  static const String getIndexBannerEndpoint = '/public/index-banner';

  // Future<IndexBannerModel> getAsync() async {
  //   var jsonStr = await rootBundle.loadString('assets/datas/indexBanner.json');

  //   var result = IndexBannerModel.fromJson(json.decode(jsonStr));
  //   return result;
  // }

  Future<IndexBannerModel> getAsync({ApiIndexbannerRequest? request}) async {
    request ??= ApiIndexbannerRequest();
    // var jsonStr = await rootBundle.loadString('assets/datas/indexBanner.json');
    var response =
        await HttpUtil().getAsync(getIndexBannerEndpoint, input: request);

    var result = IndexBannerModel.fromJson(response.data);
    return result;
  }
}
