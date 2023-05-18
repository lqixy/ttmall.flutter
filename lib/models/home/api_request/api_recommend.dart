import 'package:ttmall/models/api/request/api_request.dart';

class ApiRecommendRequest extends ApiRequest {
  late String placename;

  ApiRecommendRequest({this.placename = '首页-多图楼层'});

  ApiRecommendRequest.fromJson(Map<String, dynamic> json) {
    placename = json['placename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['placename'] = this.placename;
    return data;
  }
}
