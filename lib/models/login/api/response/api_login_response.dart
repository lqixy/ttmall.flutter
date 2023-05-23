import 'package:ttmall/utils/app_extensions.dart';

class ApiLoginResponse {
  String? key;
  String? refreshToken;
  String? usetime;
  int? expiretime;
  DateTime? expires;

  ApiLoginResponse(
      {this.key,
      this.refreshToken,
      this.usetime,
      this.expiretime,
      this.expires});

  ApiLoginResponse.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    refreshToken = json['refresh_token'];
    usetime = json['usetime'];
    expiretime = json['expiretime'];
    String expiresStr = json['expires'];

    expires = expiresStr.convertToDateTime();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['refresh_token'] = this.refreshToken;
    data['usetime'] = this.usetime;
    data['expiretime'] = this.expiretime;
    data['expires'] = this.expires;
    return data;
  }
}
