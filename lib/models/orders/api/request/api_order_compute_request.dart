import 'package:ttmall/models/api/request/api_request.dart';

class ApiOrderComputeRequest extends ApiRequest {
  int? source;
  List<ApiOrderComputeItem>? list;

  ApiOrderComputeRequest({this.source = 2, this.list});

  ApiOrderComputeRequest.fromJson(Map<String, dynamic> json) {
    source = json['source'];
    if (json['list'] != null) {
      list = <ApiOrderComputeItem>[];
      json['list'].forEach((v) {
        list!.add(new ApiOrderComputeItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['source'] = this.source;
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ApiOrderComputeItem {
  String? orderid;

  ApiOrderComputeItem({this.orderid});

  ApiOrderComputeItem.fromJson(Map<String, dynamic> json) {
    orderid = json['orderid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderid'] = this.orderid;
    return data;
  }
}
