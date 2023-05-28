import 'package:ttmall/models/api/request/api_request.dart';

class ApiOrderDetailRequest extends ApiRequest {
  String? ordersettlementid;

  ApiOrderDetailRequest({this.ordersettlementid});

  ApiOrderDetailRequest.fromJson(Map<String, dynamic> json) {
    ordersettlementid = json['ordersettlementid'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ordersettlementid'] = this.ordersettlementid;
    return data;
  }
}
