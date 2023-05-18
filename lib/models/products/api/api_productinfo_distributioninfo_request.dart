import 'package:ttmall/models/api/request/api_request.dart';

class ApiProductInfoDistributionInfoRequest extends ApiRequest {
  String? provname;
  String? cityname;
  String? countyname;
  String? addr;
  String? addrid;
  String? goodsid;

  ApiProductInfoDistributionInfoRequest(
    this.goodsid, {
    this.provname = '河南省',
    this.cityname = '郑州市',
    this.countyname = '金水区',
    this.addr = '商务外环路',
    this.addrid = '',
  });

  ApiProductInfoDistributionInfoRequest.fromJson(Map<String, dynamic> json) {
    provname = json['provname'];
    cityname = json['cityname'];
    countyname = json['countyname'];
    addr = json['addr'];
    addrid = json['addrid'];
    goodsid = json['goodsid'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['provname'] = this.provname;
    data['cityname'] = this.cityname;
    data['countyname'] = this.countyname;
    data['addr'] = this.addr;
    data['addrid'] = this.addrid;
    data['goodsid'] = this.goodsid;
    return data;
  }
}
