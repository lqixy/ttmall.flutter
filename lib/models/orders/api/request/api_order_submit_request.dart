import 'package:ttmall/models/api/request/api_request.dart';

class ApiOrderSubmitRequest extends ApiRequest {
  String? addr;
  String? addrtype;
  String? coupon;

  String? invitecode;
  String? tk;
  List<String>? tags;
  List<ApiOrderSubmitShops>? shops;
  int? score;

  ApiOrderSubmitRequest(
      {this.addr,
      this.addrtype = '0',
      this.coupon,
      this.invitecode,
      this.tk,
      this.tags,
      this.shops,
      this.score});

  ApiOrderSubmitRequest.fromJson(Map<String, dynamic> json) {
    addr = json['addr'];
    addrtype = json['addrtype'];
    coupon = json['coupon'];

    invitecode = json['invitecode'];
    tk = json['tk'];
    if (json['tags'] != null) {
      tags = <String>[];
      json['tags'].forEach((v) {
        tags!.add(v.toString());
      });
    }
    if (json['shops'] != null) {
      shops = <ApiOrderSubmitShops>[];
      json['shops'].forEach((v) {
        shops!.add(new ApiOrderSubmitShops.fromJson(v));
      });
    }
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['addr'] = this.addr;
    data['addrtype'] = this.addrtype;
    data['coupon'] = this.coupon;

    data['invitecode'] = this.invitecode;
    data['tk'] = this.tk;
    if (this.tags != null) {
      data['tags'] = this.tags!.map((v) => v.toString()).toList();
    }
    if (this.shops != null) {
      data['shops'] = this.shops!.map((v) => v.toJson()).toList();
    }
    data['score'] = this.score;
    return data;
  }
}

class ApiOrderSubmitShops {
  String? shopsid;
  String? coupon;
  int? balance;
  String? csno;
  String? freightcoupon;
  String? msg;
  int? isleaderpick;
  String? groupcode;
  String? cardsecret;
  List<ApiOrderSubmitGoods>? goods;

  ApiOrderSubmitShops(
      {this.shopsid,
      this.coupon,
      this.balance,
      this.csno,
      this.freightcoupon,
      this.msg,
      this.isleaderpick,
      this.groupcode,
      this.cardsecret,
      this.goods});

  ApiOrderSubmitShops.fromJson(Map<String, dynamic> json) {
    shopsid = json['shopsid'];
    coupon = json['coupon'];
    balance = json['balance'];
    csno = json['csno'];
    freightcoupon = json['freightcoupon'];
    msg = json['msg'];
    isleaderpick = json['isleaderpick'];
    groupcode = json['groupcode'];
    cardsecret = json['cardsecret'];
    if (json['goods'] != null) {
      goods = <ApiOrderSubmitGoods>[];
      json['goods'].forEach((v) {
        goods!.add(new ApiOrderSubmitGoods.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shopsid'] = this.shopsid;
    data['coupon'] = this.coupon;
    data['balance'] = this.balance;
    data['csno'] = this.csno;
    data['freightcoupon'] = this.freightcoupon;
    data['msg'] = this.msg;
    data['isleaderpick'] = this.isleaderpick;
    data['groupcode'] = this.groupcode;
    data['cardsecret'] = this.cardsecret;
    if (this.goods != null) {
      data['goods'] = this.goods!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ApiOrderSubmitGoods {
  String? itemid;
  int? type;
  int? buycount;

  ApiOrderSubmitGoods({this.itemid, this.type, this.buycount});

  ApiOrderSubmitGoods.fromJson(Map<String, dynamic> json) {
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
