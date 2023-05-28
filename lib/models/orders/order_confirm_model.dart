import '../address/address_model.dart';
import '../discount/discount_detail_model.dart';
import '../promotion/free_model.dart';
import '../promotion/promotion_detail_model.dart';

class OrderConfirmModel {
  String? pay;
  List<OrderShopsModel>? shops;
  AddressModel? address;
  Pickaddress? pickaddress;
  List<OrderCouponModel>? couponlist;
  String? myscore;
  String? score;
  String? scorerule;

  OrderConfirmModel(
      {this.pay,
      this.shops,
      this.address,
      this.pickaddress,
      this.couponlist,
      this.myscore,
      this.score,
      this.scorerule});

  OrderConfirmModel.fromJson(Map<String, dynamic> json) {
    pay = json['pay'];
    if (json['shops'] != null) {
      shops = <OrderShopsModel>[];
      json['shops'].forEach((v) {
        shops!.add(new OrderShopsModel.fromJson(v));
      });
    }
    address = json['address'] != null
        ? new AddressModel.fromJson(json['address'])
        : null;
    pickaddress = json['pickaddress'] != null
        ? new Pickaddress.fromJson(json['pickaddress'])
        : null;
    if (json['couponlist'] != null) {
      couponlist = <OrderCouponModel>[];
      json['couponlist'].forEach((v) {
        couponlist!.add(new OrderCouponModel.fromJson(v));
      });
    }
    myscore = json['myscore'];
    score = json['score'];
    scorerule = json['scorerule'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pay'] = this.pay;
    if (this.shops != null) {
      data['shops'] = this.shops!.map((v) => v.toJson()).toList();
    }
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    if (this.pickaddress != null) {
      data['pickaddress'] = this.pickaddress!.toJson();
    }
    if (this.couponlist != null) {
      data['couponlist'] = this.couponlist!.map((v) => v.toJson()).toList();
    }
    data['myscore'] = this.myscore;
    data['score'] = this.score;
    data['scorerule'] = this.scorerule;
    return data;
  }
}

class OrderShopsModel {
  String? shopsid;
  String? shopsname;
  String? subtotal;
  String? count;
  String? remark;
  List<OrderStoreModel>? goods;
  List<OrderCouponModel>? couponlist;
  List<OrderDiscountDetailModel>? detail;

  /// 团购
  Groupinfo? groupinfo;
  // List<Null>? nvs;

  OrderShopsModel({
    this.shopsid,
    this.shopsname,
    this.subtotal,
    this.count,
    this.goods,
    this.couponlist,
    this.detail,
    this.groupinfo,
    this.remark,
    // this.nvs
  });

  OrderShopsModel.fromJson(Map<String, dynamic> json) {
    shopsid = json['shopsid'];
    shopsname = json['shopsname'];
    subtotal = json['subtotal'];
    count = json['count'];
    remark = json['remark'];
    if (json['goods'] != null) {
      goods = <OrderStoreModel>[];
      json['goods'].forEach((v) {
        goods!.add(new OrderStoreModel.fromJson(v));
      });
    }
    if (json['couponlist'] != null) {
      couponlist = <OrderCouponModel>[];
      json['couponlist'].forEach((v) {
        couponlist!.add(new OrderCouponModel.fromJson(v));
      });
    }
    if (json['detail'] != null) {
      detail = <OrderDiscountDetailModel>[];
      json['detail'].forEach((v) {
        detail!.add(new OrderDiscountDetailModel.fromJson(v));
      });
    }
    groupinfo = json['groupinfo'] != null
        ? new Groupinfo.fromJson(json['groupinfo'])
        : null;
    // if (json['nvs'] != null) {
    //   nvs = <Null>[];
    //   json['nvs'].forEach((v) {
    //     nvs!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shopsid'] = this.shopsid;
    data['shopsname'] = this.shopsname;
    data['subtotal'] = this.subtotal;
    data['count'] = this.count;
    data['remark'] = remark;
    if (this.goods != null) {
      data['goods'] = this.goods!.map((v) => v.toJson()).toList();
    }
    if (this.couponlist != null) {
      data['couponlist'] = this.couponlist!.map((v) => v.toJson()).toList();
    }
    if (this.detail != null) {
      data['detail'] = this.detail!.map((v) => v.toJson()).toList();
    }
    if (this.groupinfo != null) {
      data['groupinfo'] = this.groupinfo!.toJson();
    }
    // if (this.nvs != null) {
    //   data['nvs'] = this.nvs!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class OrderDiscountDetailModel {
  String? label;
  String? value;

  OrderDiscountDetailModel({this.label, this.value});

  OrderDiscountDetailModel.fromJson(Map<String, dynamic> json) {
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

class OrderStoreModel {
  String? addressid;
  String? address;
  String? freebie;
  String? sum;
  String? tariff;
  List<OrderGoodsModel>? data;
  PromotionDetailModel? group;

  OrderStoreModel(
      {this.addressid,
      this.address,
      this.freebie,
      this.sum,
      this.tariff,
      this.data,
      this.group});

  OrderStoreModel.fromJson(Map<String, dynamic> json) {
    addressid = json['addressid'];
    address = json['address'];
    freebie = json['freebie'];
    sum = json['sum'];
    tariff = json['tariff'];
    if (json['data'] != null) {
      data = <OrderGoodsModel>[];
      json['data'].forEach((v) {
        data!.add(new OrderGoodsModel.fromJson(v));
      });
    }
    group = json['group'] != null
        ? new PromotionDetailModel.fromJson(json['group'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['addressid'] = this.addressid;
    data['address'] = this.address;
    data['freebie'] = this.freebie;
    data['sum'] = this.sum;
    data['tariff'] = this.tariff;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.group != null) {
      data['group'] = this.group!.toJson();
    }
    return data;
  }
}

class OrderGoodsModel {
  String? type;
  String? entryid;
  String? goodsid;
  String? goodsname;
  String? goodsdesc;
  String? goodstradestate;
  String? goodsurl;
  String? purchasenum;
  int? usecoupon;
  String? orignprice;
  String? sellprice;
  String? predictprice;
  String? predictstarttime;
  String? predictendtime;
  List<FreeModel>? free;
  String? buyflow;

  OrderGoodsModel(
      {this.type,
      this.entryid,
      this.goodsid,
      this.goodsname,
      this.goodsdesc,
      this.goodstradestate,
      this.goodsurl,
      this.purchasenum,
      this.usecoupon,
      this.orignprice,
      this.sellprice,
      this.predictprice,
      this.predictstarttime,
      this.predictendtime,
      this.free,
      this.buyflow});

  OrderGoodsModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    entryid = json['entryid'];
    goodsid = json['goodsid'];
    goodsname = json['goodsname'];
    goodsdesc = json['goodsdesc'];
    goodstradestate = json['goodstradestate'];
    goodsurl = json['goodsurl'];
    purchasenum = json['purchasenum'];
    usecoupon = json['usecoupon'];
    orignprice = json['orignprice'];
    sellprice = json['sellprice'];
    predictprice = json['predictprice'];
    predictstarttime = json['predictstarttime'];
    predictendtime = json['predictendtime'];
    if (json['free'] != null) {
      free = <FreeModel>[];
      json['free'].forEach((v) {
        free!.add(new FreeModel.fromJson(v));
      });
    }
    buyflow = json['buyflow'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['entryid'] = this.entryid;
    data['goodsid'] = this.goodsid;
    data['goodsname'] = this.goodsname;
    data['goodsdesc'] = this.goodsdesc;
    data['goodstradestate'] = this.goodstradestate;
    data['goodsurl'] = this.goodsurl;
    data['purchasenum'] = this.purchasenum;
    data['usecoupon'] = this.usecoupon;
    data['orignprice'] = this.orignprice;
    data['sellprice'] = this.sellprice;
    data['predictprice'] = this.predictprice;
    data['predictstarttime'] = this.predictstarttime;
    data['predictendtime'] = this.predictendtime;
    if (this.free != null) {
      data['free'] = this.free!.map((v) => v.toJson()).toList();
    }
    data['buyflow'] = this.buyflow;
    return data;
  }
}

// class Group {
//   List<Null>? tc;
//   List<Null>? mjz;

//   Group({this.tc, this.mjz});

//   Group.fromJson(Map<String, dynamic> json) {
//     if (json['tc'] != null) {
//       tc = <Null>[];
//       json['tc'].forEach((v) {
//         tc!.add(new Null.fromJson(v));
//       });
//     }
//     if (json['mjz'] != null) {
//       mjz = <Null>[];
//       json['mjz'].forEach((v) {
//         mjz!.add(new Null.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.tc != null) {
//       data['tc'] = this.tc!.map((v) => v.toJson()).toList();
//     }
//     if (this.mjz != null) {
//       data['mjz'] = this.mjz!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

class Groupinfo {
  String? mode;
  String? leadername;
  List<OrderFlowModel>? flowlables;

  Groupinfo({this.mode, this.leadername, this.flowlables});

  Groupinfo.fromJson(Map<String, dynamic> json) {
    mode = json['mode'];
    leadername = json['leadername'];
    if (json['flowlables'] != null) {
      flowlables = <OrderFlowModel>[];
      json['flowlables'].forEach((v) {
        flowlables!.add(new OrderFlowModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mode'] = this.mode;
    data['leadername'] = this.leadername;
    if (this.flowlables != null) {
      data['flowlables'] = this.flowlables!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderFlowModel {
  String? code;
  String? title;

  OrderFlowModel({this.code, this.title});

  OrderFlowModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['title'] = this.title;
    return data;
  }
}

class Pickaddress {
  String? pickid;
  String? addrid;
  String? name;
  String? phone;
  String? pickname;
  String? pickaddress;
  String? pickphone;
  String? remark;

  Pickaddress(
      {this.pickid,
      this.addrid,
      this.name,
      this.phone,
      this.pickname,
      this.pickaddress,
      this.pickphone,
      this.remark});

  Pickaddress.fromJson(Map<String, dynamic> json) {
    pickid = json['pickid'];
    addrid = json['addrid'];
    name = json['name'];
    phone = json['phone'];
    pickname = json['pickname'];
    pickaddress = json['pickaddress'];
    pickphone = json['pickphone'];
    remark = json['remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pickid'] = this.pickid;
    data['addrid'] = this.addrid;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['pickname'] = this.pickname;
    data['pickaddress'] = this.pickaddress;
    data['pickphone'] = this.pickphone;
    data['remark'] = this.remark;
    return data;
  }
}

class OrderCouponModel {
  String? couponid;
  String? cname;
  String? cnote;
  String? range;
  String? cvalue;
  String? amountedmoney;
  String? timelimitstart;
  String? timelimited;
  String? iscan;
  String? coupontype;
  String? maxdiscount;

  OrderCouponModel(
      {this.couponid,
      this.cname,
      this.cnote,
      this.range,
      this.cvalue,
      this.amountedmoney,
      this.timelimitstart,
      this.timelimited,
      this.iscan,
      this.coupontype,
      this.maxdiscount});

  OrderCouponModel.fromJson(Map<String, dynamic> json) {
    couponid = json['couponid'];
    cname = json['cname'];
    cnote = json['cnote'];
    range = json['range'];
    cvalue = json['cvalue'];
    amountedmoney = json['amountedmoney'];
    timelimitstart = json['timelimitstart'];
    timelimited = json['timelimited'];
    iscan = json['iscan'];
    coupontype = json['coupontype'];
    maxdiscount = json['maxdiscount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['couponid'] = this.couponid;
    data['cname'] = this.cname;
    data['cnote'] = this.cnote;
    data['range'] = this.range;
    data['cvalue'] = this.cvalue;
    data['amountedmoney'] = this.amountedmoney;
    data['timelimitstart'] = this.timelimitstart;
    data['timelimited'] = this.timelimited;
    data['iscan'] = this.iscan;
    data['coupontype'] = this.coupontype;
    data['maxdiscount'] = this.maxdiscount;
    return data;
  }
}
