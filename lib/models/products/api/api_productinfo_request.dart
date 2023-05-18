import 'package:ttmall/models/api/request/api_request.dart';

class ApiProductInfoRequest extends ApiRequest {
  late String goodsid;

  ApiProductInfoRequest(this.goodsid);

  ApiProductInfoRequest.fromJson(Map<String, dynamic> json) {
    goodsid = json['goodsid'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['goodsid'] = this.goodsid;
    return data;
  }
}
