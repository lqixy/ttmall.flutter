import 'package:ttmall/models/api/request/api_request.dart';

class ApiSetDefaultRequest extends ApiRequest {
  String? addrid;

  ApiSetDefaultRequest({this.addrid});

  ApiSetDefaultRequest.fromJson(Map<String, dynamic> json) {
    addrid = json['addrid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['addrid'] = this.addrid;
    return data;
  }
}
