import 'package:ttmall/utils/app_extensions.dart';

class ApiOrderListResponse {
  List<ApiOrderListItem>? list;

  ApiOrderListResponse({this.list});

  ApiOrderListResponse.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <ApiOrderListItem>[];
      json['list'].forEach((v) {
        list!.add(ApiOrderListItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ApiOrderListItem {
  String? ordersettlementid;
  String? orderidshow;
  String? needidcard;
  String? logisticsno;
  String? ispick;
  int? orderstatus;
  String? ordertype;
  Predictobj? predictobj;
  String? shopsid;
  String? shopsname;
  DateTime? time;
  String? payexpire;
  String? price;
  String? yf;
  String? tariff;
  String? from;
  int? isshare;
  List<ApiOrderListItemGoods>? goods;

  ApiOrderListItem(
      {this.ordersettlementid,
      this.orderidshow,
      this.needidcard,
      this.logisticsno,
      this.ispick,
      this.orderstatus,
      this.ordertype,
      this.predictobj,
      this.shopsid,
      this.shopsname,
      this.time,
      this.payexpire,
      this.price,
      this.yf,
      this.tariff,
      this.from,
      this.isshare,
      this.goods});

  ApiOrderListItem.fromJson(Map<String, dynamic> json) {
    ordersettlementid = json['ordersettlementid'];
    orderidshow = json['orderidshow'];
    needidcard = json['needidcard'];
    logisticsno = json['logisticsno'];
    ispick = json['ispick'];
    String orderstatusStr = json['orderstatus'];
    orderstatus = orderstatusStr.convertToInt();
    ordertype = json['ordertype'];
    predictobj = json['predictobj'] != null
        ? Predictobj.fromJson(json['predictobj'])
        : null;
    shopsid = json['shopsid'];
    shopsname = json['shopsname'];
    String timeStr = json['time'];
    time = timeStr.convertToDateTime();
    payexpire = json['payexpire'];
    price = json['price'];
    yf = json['yf'];
    tariff = json['tariff'];
    from = json['from'];
    isshare = json['isshare'];
    if (json['goods'] != null) {
      goods = <ApiOrderListItemGoods>[];
      json['goods'].forEach((v) {
        goods!.add(ApiOrderListItemGoods.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ordersettlementid'] = ordersettlementid;
    data['orderidshow'] = orderidshow;
    data['needidcard'] = needidcard;
    data['logisticsno'] = logisticsno;
    data['ispick'] = ispick;
    data['orderstatus'] = orderstatus;
    data['ordertype'] = ordertype;
    if (predictobj != null) {
      data['predictobj'] = predictobj!.toJson();
    }
    data['shopsid'] = shopsid;
    data['shopsname'] = shopsname;
    data['time'] = time;
    data['payexpire'] = payexpire;
    data['price'] = price;
    data['yf'] = yf;
    data['tariff'] = tariff;
    data['from'] = from;
    data['isshare'] = isshare;
    if (goods != null) {
      data['goods'] = goods!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Predictobj {
  String? status;

  Predictobj({this.status});

  Predictobj.fromJson(Map<String, dynamic> json) {
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    return data;
  }
}

class ApiOrderListItemGoods {
  String? itemid;
  String? type;
  String? entryid;
  String? gid;
  String? gn;
  String? gifo;
  String? gp;
  String? sumprice;
  int? n;
  String? gpurl;
  ApiOrderListItemRefundamount? refundamount;
  ApiOrderListItemRefundamount? refundgoods;
  String? commentstatus;

  ApiOrderListItemGoods(
      {this.itemid,
      this.type,
      this.entryid,
      this.gid,
      this.gn,
      this.gifo,
      this.gp,
      this.sumprice,
      this.n,
      this.gpurl,
      this.refundamount,
      this.refundgoods,
      this.commentstatus});

  ApiOrderListItemGoods.fromJson(Map<String, dynamic> json) {
    itemid = json['itemid'];
    type = json['type'];
    entryid = json['entryid'];
    gid = json['gid'];
    gn = json['gn'];
    gifo = json['gifo'];
    gp = json['gp'];
    sumprice = json['sumprice'];
    String nStr = json['n'];
    n = nStr.convertToInt();
    gpurl = json['gpurl'];
    refundamount = json['refundamount'] != null
        ? ApiOrderListItemRefundamount.fromJson(json['refundamount'])
        : null;
    refundgoods = json['refundgoods'] != null
        ? ApiOrderListItemRefundamount.fromJson(json['refundgoods'])
        : null;
    commentstatus = json['commentstatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['itemid'] = itemid;
    data['type'] = type;
    data['entryid'] = entryid;
    data['gid'] = gid;
    data['gn'] = gn;
    data['gifo'] = gifo;
    data['gp'] = gp;
    data['sumprice'] = sumprice;
    data['n'] = n;
    data['gpurl'] = gpurl;
    if (refundamount != null) {
      data['refundamount'] = refundamount!.toJson();
    }
    if (refundgoods != null) {
      data['refundgoods'] = refundgoods!.toJson();
    }
    data['commentstatus'] = commentstatus;
    return data;
  }
}

class ApiOrderListItemRefundamount {
  String? status;
  String? rejectreason;

  ApiOrderListItemRefundamount({this.status, this.rejectreason});

  ApiOrderListItemRefundamount.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    rejectreason = json['rejectreason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['rejectreason'] = rejectreason;
    return data;
  }
}
