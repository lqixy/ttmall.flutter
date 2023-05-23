import 'package:ttmall/models/api/request/api_request.dart';

class ApiLoginRequest extends ApiRequest {
  int? tk;
  String? loginname;
  String? pwd;
  String? vercode;

  ApiLoginRequest({this.tk, this.loginname, this.pwd, this.vercode});

  ApiLoginRequest.fromJson(Map<String, dynamic> json) {
    tk = json['tk'];
    loginname = json['loginname'];
    pwd = json['pwd'];
    vercode = json['vercode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tk'] = this.tk;
    data['loginname'] = this.loginname;
    data['pwd'] = this.pwd;
    data['vercode'] = this.vercode;
    return data;
  }
}
