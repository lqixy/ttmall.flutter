import 'package:ttmall/models/api/request/api_request.dart';

class ApiCartAddRequest extends ApiRequest {
  List<ApiCartGoodsImte>? goods;

  ApiCartAddRequest({this.goods});

  ApiCartAddRequest.fromJson(Map<String, dynamic> json) {
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

class ApiCartGoodsImte {
  String? itemid;
  int? type;
  int? buycount;

  ApiCartGoodsImte({this.itemid, this.type, this.buycount});

  ApiCartGoodsImte.fromJson(Map<String, dynamic> json) {
    itemid = json['itemid'];
    type = json['type'];
    buycount = json['buycount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemid'] = this.itemid;
    data['type'] = this.type;
    data['buycount'] = this.buycount;
    return data;
  }
}
