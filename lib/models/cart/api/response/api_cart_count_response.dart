import 'package:ttmall/utils/app_extensions.dart';

class ApiCartCountResponse {
  int? count;

  ApiCartCountResponse({this.count});

  ApiCartCountResponse.fromJson(Map<String, dynamic> json) {
    String countStr = json['count'];

    count = countStr.convertToInt();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    return data;
  }
}
