import 'package:ttmall/models/api/request/api_request.dart';

class ApiDicRequest extends ApiRequest {
  String? type;

  ApiDicRequest({this.type});

  ApiDicRequest.fromJson(Map<String, dynamic> json) {
    type = json['type'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    return data;
  }
}
