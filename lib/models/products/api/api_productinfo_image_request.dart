import 'package:ttmall/models/api/request/api_request.dart';

class ApiProductInfoImageRequest extends ApiRequest {
  late String goodsid;

  ApiProductInfoImageRequest(this.goodsid);

  ApiProductInfoImageRequest.fromJson(Map<String, dynamic> json) {
    goodsid = json['goodsid'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['goodsid'] = this.goodsid;
    return data;
  }
}
