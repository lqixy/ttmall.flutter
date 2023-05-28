import 'package:ttmall/utils/app_extensions.dart';

class ApiOrderDetailResponse {
  String? shopsid;
  String? shopsname;
  String? orderid;
  String? orderidshow;
  String? needidcard;
  int? orderstatus;
  String? ordertype;
  DateTime? time;
  int? payexpire;
  String? confirmexpire;
  String? price;
  String? message;
  String? from;
  String? yf;
  String? ispick;
  String? isrefund;
  Weekinfo? weekinfo;
  Verification? verification;
  Addobj? addobj;
  Pick? pick;
  Predictobj? predictobj;
  List<ApiOrderDetailGoods>? goods;
  List<Payment>? payment;
  Logistics? logistics;
  Groupobj? groupobj;
  // Approveinfo? approveinfo;
  String? invitecode;
  // List<Null>? refundwaybillinfos;

  String get orderStatusDes {
    switch (orderstatus) {
      case 10:
        return '等待付款';
      case 20:
        return '已付款';
      case 50:
        return '交易关闭';
      case 60:
        return '已完成';
      default:
        return '';
    }
  }

  ApiOrderDetailResponse({
    this.shopsid,
    this.shopsname,
    this.orderid,
    this.orderidshow,
    this.needidcard,
    this.orderstatus,
    this.ordertype,
    this.time,
    this.payexpire,
    this.confirmexpire,
    this.price,
    this.message,
    this.from,
    this.yf,
    this.ispick,
    this.isrefund,
    this.weekinfo,
    this.verification,
    this.addobj,
    this.pick,
    this.predictobj,
    this.goods,
    this.payment,
    this.logistics,
    this.groupobj,
    // this.approveinfo,
    this.invitecode,
    // this.refundwaybillinfos
  });

  ApiOrderDetailResponse.fromJson(Map<String, dynamic> json) {
    shopsid = json['shopsid'];
    shopsname = json['shopsname'];
    orderid = json['orderid'];
    orderidshow = json['orderidshow'];
    needidcard = json['needidcard'];
    String orderstatusStr = json['orderstatus'];
    orderstatus = orderstatusStr.convertToInt();
    ordertype = json['ordertype'];
    String timeStr = json['time'];
    time = timeStr.convertToDateTime();
    String payexpireStr = json['payexpire'];
    payexpire = payexpireStr.convertToInt();
    confirmexpire = json['confirmexpire'];
    price = json['price'];
    message = json['message'];
    from = json['from'];
    yf = json['yf'];
    ispick = json['ispick'];
    isrefund = json['isrefund'];
    weekinfo =
        json['weekinfo'] != null ? Weekinfo.fromJson(json['weekinfo']) : null;
    verification = json['verification'] != null
        ? Verification.fromJson(json['verification'])
        : null;
    addobj = json['addobj'] != null ? Addobj.fromJson(json['addobj']) : null;
    pick = json['pick'] != null ? Pick.fromJson(json['pick']) : null;
    predictobj = json['predictobj'] != null
        ? Predictobj.fromJson(json['predictobj'])
        : null;
    if (json['goods'] != null) {
      goods = <ApiOrderDetailGoods>[];
      json['goods'].forEach((v) {
        goods!.add(ApiOrderDetailGoods.fromJson(v));
      });
    }
    if (json['payment'] != null) {
      payment = <Payment>[];
      json['payment'].forEach((v) {
        payment!.add(Payment.fromJson(v));
      });
    }
    logistics = json['logistics'] != null
        ? Logistics.fromJson(json['logistics'])
        : null;
    groupobj =
        json['groupobj'] != null ? Groupobj.fromJson(json['groupobj']) : null;
    // approveinfo = json['approveinfo'] != null
    //     ? new Approveinfo.fromJson(json['approveinfo'])
    //     : null;
    invitecode = json['invitecode'];
    // if (json['refundwaybillinfos'] != null) {
    //   refundwaybillinfos = <Null>[];
    //   json['refundwaybillinfos'].forEach((v) {
    //     refundwaybillinfos!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['shopsid'] = shopsid;
    data['shopsname'] = shopsname;
    data['orderid'] = orderid;
    data['orderidshow'] = orderidshow;
    data['needidcard'] = needidcard;
    data['orderstatus'] = orderstatus;
    data['ordertype'] = ordertype;
    data['time'] = time;
    data['payexpire'] = payexpire;
    data['confirmexpire'] = confirmexpire;
    data['price'] = price;
    data['message'] = message;
    data['from'] = from;
    data['yf'] = yf;
    data['ispick'] = ispick;
    data['isrefund'] = isrefund;
    if (weekinfo != null) {
      data['weekinfo'] = weekinfo!.toJson();
    }
    if (verification != null) {
      data['verification'] = verification!.toJson();
    }
    if (addobj != null) {
      data['addobj'] = addobj!.toJson();
    }
    if (pick != null) {
      data['pick'] = pick!.toJson();
    }
    if (predictobj != null) {
      data['predictobj'] = predictobj!.toJson();
    }
    if (goods != null) {
      data['goods'] = goods!.map((v) => v.toJson()).toList();
    }
    if (payment != null) {
      data['payment'] = payment!.map((v) => v.toJson()).toList();
    }
    if (logistics != null) {
      data['logistics'] = logistics!.toJson();
    }
    if (groupobj != null) {
      data['groupobj'] = groupobj!.toJson();
    }
    // if (this.approveinfo != null) {
    //   data['approveinfo'] = this.approveinfo!.toJson();
    // }
    data['invitecode'] = invitecode;
    // if (this.refundwaybillinfos != null) {
    //   data['refundwaybillinfos'] =
    //       this.refundwaybillinfos!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Weekinfo {
  String? ismilkbox;
  // List<Null>? flowlables;

  Weekinfo({
    this.ismilkbox,
    //  this.flowlables
  });

  Weekinfo.fromJson(Map<String, dynamic> json) {
    ismilkbox = json['ismilkbox'];
    // if (json['flowlables'] != null) {
    //   flowlables = <Null>[];
    //   json['flowlables'].forEach((v) {
    //     flowlables!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ismilkbox'] = ismilkbox;
    // if (this.flowlables != null) {
    //   data['flowlables'] = this.flowlables!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Verification {
  String? vcode;
  String? vstatus;
  String? vurl;

  Verification({this.vcode, this.vstatus, this.vurl});

  Verification.fromJson(Map<String, dynamic> json) {
    vcode = json['vcode'];
    vstatus = json['vstatus'];
    vurl = json['vurl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vcode'] = vcode;
    data['vstatus'] = vstatus;
    data['vurl'] = vurl;
    return data;
  }
}

class Addobj {
  String? addrid;
  String? name;
  String? phone;
  String? provid;
  String? cityid;
  String? countyid;
  String? provname;
  String? cityname;
  String? countyname;
  String? addr;
  String? idcard;
  String? isdefault;

  String get addressDetail => '$provname$cityname$countyname$addr';

  Addobj(
      {this.addrid,
      this.name,
      this.phone,
      this.provid,
      this.cityid,
      this.countyid,
      this.provname,
      this.cityname,
      this.countyname,
      this.addr,
      this.idcard,
      this.isdefault});

  Addobj.fromJson(Map<String, dynamic> json) {
    addrid = json['addrid'];
    name = json['name'];
    phone = json['phone'];
    provid = json['provid'];
    cityid = json['cityid'];
    countyid = json['countyid'];
    provname = json['provname'];
    cityname = json['cityname'];
    countyname = json['countyname'];
    addr = json['addr'];
    idcard = json['idcard'];
    isdefault = json['isdefault'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['addrid'] = addrid;
    data['name'] = name;
    data['phone'] = phone;
    data['provid'] = provid;
    data['cityid'] = cityid;
    data['countyid'] = countyid;
    data['provname'] = provname;
    data['cityname'] = cityname;
    data['countyname'] = countyname;
    data['addr'] = addr;
    data['idcard'] = idcard;
    data['isdefault'] = isdefault;
    return data;
  }
}

class Pick {
  String? pickid;
  String? name;
  String? phone;
  String? idcard;
  String? pickname;
  String? pickphone;
  String? pickaddress;
  String? remark;

  Pick(
      {this.pickid,
      this.name,
      this.phone,
      this.idcard,
      this.pickname,
      this.pickphone,
      this.pickaddress,
      this.remark});

  Pick.fromJson(Map<String, dynamic> json) {
    pickid = json['pickid'];
    name = json['name'];
    phone = json['phone'];
    idcard = json['idcard'];
    pickname = json['pickname'];
    pickphone = json['pickphone'];
    pickaddress = json['pickaddress'];
    remark = json['remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pickid'] = pickid;
    data['name'] = name;
    data['phone'] = phone;
    data['idcard'] = idcard;
    data['pickname'] = pickname;
    data['pickphone'] = pickphone;
    data['pickaddress'] = pickaddress;
    data['remark'] = remark;
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

class ApiOrderDetailGoods {
  String? addressid;
  String? address;
  String? freebie;
  String? sum;
  String? tariff;
  List<ApiOrderDetailGoodsData>? data;

  ApiOrderDetailGoods(
      {this.addressid,
      this.address,
      this.freebie,
      this.sum,
      this.tariff,
      this.data});

  ApiOrderDetailGoods.fromJson(Map<String, dynamic> json) {
    addressid = json['addressid'];
    address = json['address'];
    freebie = json['freebie'];
    sum = json['sum'];
    tariff = json['tariff'];
    if (json['data'] != null) {
      data = <ApiOrderDetailGoodsData>[];
      json['data'].forEach((v) {
        data!.add(ApiOrderDetailGoodsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['addressid'] = addressid;
    data['address'] = address;
    data['freebie'] = freebie;
    data['sum'] = sum;
    data['tariff'] = tariff;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ApiOrderDetailGoodsData {
  String? type;
  String? itemid;
  String? entryid;
  String? goodsid;
  String? goodsurl;
  String? goodsname;
  String? goodsdesc;
  String? orignprice;
  String? sellprice;
  String? purchasenum;
  String? stock;
  String? refundprice;
  String? unitrefundprice;
  String? predictprice;
  String? finalprice;
  // List<Null>? free;
  Refundamount? refundamount;
  Refundamount? refundgoods;
  String? commentstatus;
  Weekinfo? weekinfo;

  ApiOrderDetailGoodsData(
      {this.type,
      this.itemid,
      this.entryid,
      this.goodsid,
      this.goodsurl,
      this.goodsname,
      this.goodsdesc,
      this.orignprice,
      this.sellprice,
      this.purchasenum,
      this.stock,
      this.refundprice,
      this.unitrefundprice,
      this.predictprice,
      this.finalprice,
      // this.free,
      this.refundamount,
      this.refundgoods,
      this.commentstatus,
      this.weekinfo});

  ApiOrderDetailGoodsData.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    itemid = json['itemid'];
    entryid = json['entryid'];
    goodsid = json['goodsid'];
    goodsurl = json['goodsurl'];
    goodsname = json['goodsname'];
    goodsdesc = json['goodsdesc'];
    orignprice = json['orignprice'];
    sellprice = json['sellprice'];
    purchasenum = json['purchasenum'];
    stock = json['stock'];
    refundprice = json['refundprice'];
    unitrefundprice = json['unitrefundprice'];
    predictprice = json['predictprice'];
    finalprice = json['finalprice'];
    // if (json['free'] != null) {
    //   free = <Null>[];
    //   json['free'].forEach((v) {
    //     free!.add(new Null.fromJson(v));
    //   });
    // }
    refundamount = json['refundamount'] != null
        ? Refundamount.fromJson(json['refundamount'])
        : null;
    refundgoods = json['refundgoods'] != null
        ? Refundamount.fromJson(json['refundgoods'])
        : null;
    commentstatus = json['commentstatus'];
    weekinfo =
        json['weekinfo'] != null ? Weekinfo.fromJson(json['weekinfo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['itemid'] = itemid;
    data['entryid'] = entryid;
    data['goodsid'] = goodsid;
    data['goodsurl'] = goodsurl;
    data['goodsname'] = goodsname;
    data['goodsdesc'] = goodsdesc;
    data['orignprice'] = orignprice;
    data['sellprice'] = sellprice;
    data['purchasenum'] = purchasenum;
    data['stock'] = stock;
    data['refundprice'] = refundprice;
    data['unitrefundprice'] = unitrefundprice;
    data['predictprice'] = predictprice;
    data['finalprice'] = finalprice;
    // if (this.free != null) {
    //   data['free'] = this.free!.map((v) => v.toJson()).toList();
    // }
    if (refundamount != null) {
      data['refundamount'] = refundamount!.toJson();
    }
    if (refundgoods != null) {
      data['refundgoods'] = refundgoods!.toJson();
    }
    data['commentstatus'] = commentstatus;
    if (weekinfo != null) {
      data['weekinfo'] = weekinfo!.toJson();
    }
    return data;
  }
}

class Refundamount {
  String? status;
  String? rejectreason;

  Refundamount({this.status, this.rejectreason});

  Refundamount.fromJson(Map<String, dynamic> json) {
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

// class Weekinfo {
//   List<Null>? weeks;
//   int? times;

//   Weekinfo({this.weeks, this.times});

//   Weekinfo.fromJson(Map<String, dynamic> json) {
//     if (json['weeks'] != null) {
//       weeks = <Null>[];
//       json['weeks'].forEach((v) {
//         weeks!.add(new Null.fromJson(v));
//       });
//     }
//     times = json['times'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.weeks != null) {
//       data['weeks'] = this.weeks!.map((v) => v.toJson()).toList();
//     }
//     data['times'] = this.times;
//     return data;
//   }
// }

class Payment {
  String? label;
  String? value;

  Payment({this.label, this.value});

  Payment.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['value'] = value;
    return data;
  }
}

class Logistics {
  String? kddh;
  String? kdsj;
  // List<Null>? wljl;

  Logistics({
    this.kddh,
    this.kdsj,
  });

  Logistics.fromJson(Map<String, dynamic> json) {
    kddh = json['kddh'];
    kdsj = json['kdsj'];
    // if (json['wljl'] != null) {
    //   wljl = <Null>[];
    //   json['wljl'].forEach((v) {
    //     wljl!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kddh'] = kddh;
    data['kdsj'] = kdsj;
    // if (this.wljl != null) {
    //   data['wljl'] = this.wljl!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Groupobj {
  String? groupcode;
  String? role;
  String? endtime;
  String? limitperson;
  String? groupstatus;
  String? mode;
  // List<Null>? users;
  // List<Null>? flowlables;

  Groupobj({
    this.groupcode,
    this.role,
    this.endtime,
    this.limitperson,
    this.groupstatus,
    this.mode,
    // this.users,
    // this.flowlables
  });

  Groupobj.fromJson(Map<String, dynamic> json) {
    groupcode = json['groupcode'];
    role = json['role'];
    endtime = json['endtime'];
    limitperson = json['limitperson'];
    groupstatus = json['groupstatus'];
    mode = json['mode'];
    // if (json['users'] != null) {
    //   users = <Null>[];
    //   json['users'].forEach((v) {
    //     users!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['flowlables'] != null) {
    //   flowlables = <Null>[];
    //   json['flowlables'].forEach((v) {
    //     flowlables!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['groupcode'] = groupcode;
    data['role'] = role;
    data['endtime'] = endtime;
    data['limitperson'] = limitperson;
    data['groupstatus'] = groupstatus;
    data['mode'] = mode;
    // if (this.users != null) {
    //   data['users'] = this.users!.map((v) => v.toJson()).toList();
    // }
    // if (this.flowlables != null) {
    //   data['flowlables'] = this.flowlables!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

// class Approveinfo {
//   List<Null>? flows;
//   List<Null>? images;

//   Approveinfo({this.flows, this.images});

//   Approveinfo.fromJson(Map<String, dynamic> json) {
//     if (json['flows'] != null) {
//       flows = <Null>[];
//       json['flows'].forEach((v) {
//         flows!.add(new Null.fromJson(v));
//       });
//     }
//     if (json['images'] != null) {
//       images = <Null>[];
//       json['images'].forEach((v) {
//         images!.add(new Null.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.flows != null) {
//       data['flows'] = this.flows!.map((v) => v.toJson()).toList();
//     }
//     if (this.images != null) {
//       data['images'] = this.images!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
