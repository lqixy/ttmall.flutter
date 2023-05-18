import 'package:ttmall/models/api/request/api_request.dart';

class ApiIndexbannerRequest extends ApiRequest {
  String? adtime;
  String? menutime;
  String? noticetime;
  String? showtime;

  ApiIndexbannerRequest(
      {this.adtime, this.menutime, this.noticetime, this.showtime});

  ApiIndexbannerRequest.fromJson(Map<String, dynamic> json) {
    adtime = json['adtime'];
    menutime = json['menutime'];
    noticetime = json['noticetime'];
    showtime = json['showtime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adtime'] = this.adtime;
    data['menutime'] = this.menutime;
    data['noticetime'] = this.noticetime;
    data['showtime'] = this.showtime;
    return data;
  }
}
