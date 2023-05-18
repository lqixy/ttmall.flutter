import '../../api/request/api_request.dart';

class ApiRecommendGoodsRequest extends ApiRequest {
  late String goodsid;

  ApiRecommendGoodsRequest(this.goodsid);

  ApiRecommendGoodsRequest.fromJson(Map<String, dynamic> json) {
    goodsid = json['goodsid'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['goodsid'] = this.goodsid;
    return data;
  }
}
