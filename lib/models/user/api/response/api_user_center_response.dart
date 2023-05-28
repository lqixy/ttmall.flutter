import 'package:ttmall/utils/app_extensions.dart';

class ApiUserCenterResponse {
  int? allorder;
  int? scores;
  String? couponnum;
  int? unpaidorder;
  int? noreceiveorder;
  int? nocommentorder;
  int? waitsendorder;
  int? refundorder;

  ApiUserCenterResponse(
      {this.allorder,
      this.scores,
      this.couponnum,
      this.unpaidorder,
      this.noreceiveorder,
      this.nocommentorder,
      this.waitsendorder,
      this.refundorder});

  ApiUserCenterResponse.fromJson(Map<String, dynamic> json) {
    String allorderStr = json['allorder'];
    allorder = allorderStr.convertToInt();
    String scoreStr = json['scores'];
    scores = scoreStr.convertToInt();
    couponnum = json['couponnum'];
    String unpaidorderStr = json['unpaidorder'];

    unpaidorder = unpaidorderStr.convertToInt();
    String noreceiveorderStr = json['noreceiveorder'];

    noreceiveorder = noreceiveorderStr.convertToInt();
    String nocommentorderStr = json['nocommentorder'];

    nocommentorder = nocommentorderStr.convertToInt();
    String waitsendorderStr = json['waitsendorder'];

    waitsendorder = waitsendorderStr.convertToInt();
    String refundorderStr = json['refundorder'];

    refundorder = refundorderStr.convertToInt();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['allorder'] = this.allorder;
    data['scores'] = this.scores;
    data['couponnum'] = this.couponnum;
    data['unpaidorder'] = this.unpaidorder;
    data['noreceiveorder'] = this.noreceiveorder;
    data['nocommentorder'] = this.nocommentorder;
    data['waitsendorder'] = this.waitsendorder;
    data['refundorder'] = this.refundorder;
    return data;
  }
}
