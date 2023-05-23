import 'package:ttmall/models/api/request/api_request.dart';

import 'api_cart_add_request.dart';

class ApiCartUpdateRequest extends ApiRequest {
  List<ApiCartGoodsImte>? goods;

  ApiCartUpdateRequest({this.goods});

  ApiCartUpdateRequest.fromJson(Map<String, dynamic> json) {
    if (json['goods'] != null) {
      goods = <ApiCartGoodsImte>[];
      json['goods'].forEach((v) {
        goods!.add(new ApiCartGoodsImte.fromJson(v));
      });
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.goods != null) {
      data['goods'] = this.goods!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
