import 'package:ttmall/models/address/address_model.dart';

class ApiAddressResponse {
  List<AddressModel>? list;

  ApiAddressResponse({this.list});

  ApiAddressResponse.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <AddressModel>[];
      json['list'].forEach((v) {
        list!.add(new AddressModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
