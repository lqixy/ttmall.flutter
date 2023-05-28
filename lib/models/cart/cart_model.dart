import 'package:ttmall/utils/app_extensions.dart';

import '../promotion/free_model.dart';

class CartModel {
  double? total;
  double? coupon;
  List<CartShopsModel>? list;
  List<CartDetail>? detail;

  double? get realPay => total! - coupon!;

  CartModel({this.total, this.coupon, this.list, this.detail});

  CartModel.fromJson(Map<String, dynamic> json) {
    String totalStr = json['total'];

    total = totalStr.convertToDouble();
    String couponStr = json['coupon'];
    coupon = couponStr.convertToDouble();
    if (json['list'] != null) {
      list = <CartShopsModel>[];
      json['list'].forEach((v) {
        list!.add(CartShopsModel.fromJson(v));
      });
    }
    if (json['detail'] != null) {
      detail = <CartDetail>[];
      json['detail'].forEach((v) {
        detail!.add(CartDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['coupon'] = coupon;
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    if (detail != null) {
      data['detail'] = detail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartShopsModel {
  String? shopsId;
  String? shopsName;
  List<CartStoreModel>? list;
  List<Coupons>? coupons;
  String? couponlabel;

  CartShopsModel(CartShopsModel e,
      {this.shopsId,
      this.shopsName,
      this.list,
      this.coupons,
      this.couponlabel});

  CartShopsModel.fromJson(Map<String, dynamic> json) {
    shopsId = json['shopsid'];
    shopsName = json['shopsname'];
    if (json['list'] != null) {
      list = <CartStoreModel>[];
      json['list'].forEach((v) {
        list!.add(CartStoreModel.fromJson(v));
      });
    }
    if (json['coupons'] != null) {
      coupons = <Coupons>[];
      json['coupons'].forEach((v) {
        coupons!.add(Coupons.fromJson(v));
      });
    }
    couponlabel = json['couponlabel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['shopsid'] = shopsId;
    data['shopsname'] = shopsName;
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    if (coupons != null) {
      data['coupons'] = coupons!.map((v) => v.toJson()).toList();
    }
    data['couponlabel'] = couponlabel;
    return data;
  }
}

class CartStoreModel {
  String? addressid;
  String? address;
  String? addressIcon;
  String? freebie;
  String? tariff;
  String? choiceTariff;
  String? freebiedesign;
  List<CartGoodsModel>? data;
  CartGroupModel? group;

  CartStoreModel(
      {this.addressid,
      this.address,
      this.addressIcon,
      this.freebie,
      this.tariff,
      this.choiceTariff,
      this.freebiedesign,
      this.data,
      this.group});

  CartStoreModel.fromJson(Map<String, dynamic> json) {
    addressid = json['addressid'];
    address = json['address'];
    addressIcon = json['address_icon'];
    freebie = json['freebie'];
    tariff = json['Tariff'];
    choiceTariff = json['ChoiceTariff'];
    freebiedesign = json['freebiedesign'];
    if (json['data'] != null) {
      data = <CartGoodsModel>[];
      json['data'].forEach((v) {
        data!.add(CartGoodsModel.fromJson(v));
      });
    }
    group =
        json['group'] != null ? CartGroupModel.fromJson(json['group']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['addressid'] = addressid;
    data['address'] = address;
    data['address_icon'] = addressIcon;
    data['freebie'] = freebie;
    data['Tariff'] = tariff;
    data['ChoiceTariff'] = choiceTariff;
    data['freebiedesign'] = freebiedesign;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (group != null) {
      data['group'] = group!.toJson();
    }
    return data;
  }
}

class CartGoodsModel {
  int? type;
  bool? ischeck;
  String? entryid;
  List<String>? hasentryid;
  String? itemid;
  int? purchasenum;
  List<FreeModel>? free;
  String? goodsid;
  String? goodsurl;
  String? goodsname;
  String? goodsdesc;
  String? sellprice;
  int? stock;
  String? limitbuy;
  String? oncelimitbuy;
  String? praiserate;

  CartGoodsModel(
      {this.type,
      this.ischeck,
      this.entryid,
      this.hasentryid,
      this.itemid,
      this.purchasenum,
      this.free,
      this.goodsid,
      this.goodsurl,
      this.goodsname,
      this.goodsdesc,
      this.sellprice,
      this.stock,
      this.limitbuy,
      this.oncelimitbuy,
      this.praiserate});

  CartGoodsModel.fromJson(Map<String, dynamic> json) {
    String typeStr = json['type'];
    type = typeStr.convertToInt();
    ischeck = json['ischeck'] == '1';
    entryid = json['entryid'];
    hasentryid = json['hasentryid'].cast<String>();
    itemid = json['itemid'];
    String purchasenumStr = json['purchasenum'];
    purchasenum = purchasenumStr.convertToInt();
    if (json['free'] != null) {
      free = <FreeModel>[];
      json['free'].forEach((v) {
        free!.add(FreeModel.fromJson(v));
      });
    }
    goodsid = json['goodsid'];
    goodsurl = json['goodsurl'];
    goodsname = json['goodsname'];
    goodsdesc = json['goodsdesc'];
    sellprice = json['sellprice'];
    String stockStr = json['stock'];
    stock = stockStr.convertToInt();
    limitbuy = json['limitbuy'];
    oncelimitbuy = json['oncelimitbuy'];
    praiserate = json['praiserate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['ischeck'] = ischeck;
    data['entryid'] = entryid;
    data['hasentryid'] = hasentryid;
    data['itemid'] = itemid;
    data['purchasenum'] = purchasenum;
    if (free != null) {
      data['free'] = free!.map((v) => v.toJson()).toList();
    }
    data['goodsid'] = goodsid;
    data['goodsurl'] = goodsurl;
    data['goodsname'] = goodsname;
    data['goodsdesc'] = goodsdesc;
    data['sellprice'] = sellprice;
    data['stock'] = stock;
    data['limitbuy'] = limitbuy;
    data['oncelimitbuy'] = oncelimitbuy;
    data['praiserate'] = praiserate;
    return data;
  }
}

// class CartFreeModel {
//   String? label;
//   int? count;

//   CartFreeModel({this.label, this.count});

//   CartFreeModel.fromJson(Map<String, dynamic> json) {
//     label = json['label'];
//     count = json['count'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['label'] = label;
//     data['count'] = count;
//     return data;
//   }
// }

class CartGroupModel {
  List<Tc>? tc;
  List<Nyrxg>? nyrxg;
  List<Mjz>? mjz;

  CartGroupModel({this.tc, this.nyrxg, this.mjz});

  CartGroupModel.fromJson(Map<String, dynamic> json) {
    if (json['tc'] != null) {
      tc = <Tc>[];
      json['tc'].forEach((v) {
        tc!.add(Tc.fromJson(v));
      });
    }
    if (json['nyrxg'] != null) {
      nyrxg = <Nyrxg>[];
      json['nyrxg'].forEach((v) {
        nyrxg!.add(Nyrxg.fromJson(v));
      });
    }
    if (json['mjz'] != null) {
      mjz = <Mjz>[];
      json['mjz'].forEach((v) {
        mjz!.add(Mjz.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (tc != null) {
      data['tc'] = tc!.map((v) => v.toJson()).toList();
    }
    if (nyrxg != null) {
      data['nyrxg'] = nyrxg!.map((v) => v.toJson()).toList();
    }
    if (mjz != null) {
      data['mjz'] = mjz!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tc {
  String? entryid;
  String? label;
  int? count;
  String? sum;

  Tc({this.entryid, this.label, this.count, this.sum});

  Tc.fromJson(Map<String, dynamic> json) {
    entryid = json['entryid'];
    label = json['label'];
    count = json['count'];
    sum = json['sum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['entryid'] = entryid;
    data['label'] = label;
    data['count'] = count;
    data['sum'] = sum;
    return data;
  }
}

class Nyrxg {
  String? entryid;
  String? title;
  String? label;
  String? status;
  String? sumPrice;

  Nyrxg({this.entryid, this.title, this.label, this.status, this.sumPrice});

  Nyrxg.fromJson(Map<String, dynamic> json) {
    entryid = json['entryid'];
    title = json['Title'];
    label = json['Label'];
    status = json['Status'];
    sumPrice = json['SumPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['entryid'] = entryid;
    data['Title'] = title;
    data['Label'] = label;
    data['Status'] = status;
    data['SumPrice'] = sumPrice;
    return data;
  }
}

class Mjz {
  String? entryid;
  int? type;
  String? mje;
  String? label;
  int? zPCount;
  String? sum;
  String? yhSum;
  String? isSatisfy;
  List<CartGoodsModel>? zp;

  Mjz(
      {this.entryid,
      this.type,
      this.mje,
      this.label,
      this.zPCount,
      this.sum,
      this.yhSum,
      this.isSatisfy,
      this.zp});

  Mjz.fromJson(Map<String, dynamic> json) {
    entryid = json['entryid'];
    type = json['Type'];
    mje = json['mje'];
    label = json['Label'];
    zPCount = json['ZPCount'];
    sum = json['Sum'];
    yhSum = json['yhSum'];
    isSatisfy = json['IsSatisfy'];
    if (json['zp'] != null) {
      zp = <CartGoodsModel>[];
      json['zp'].forEach((v) {
        zp!.add(CartGoodsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['entryid'] = entryid;
    data['Type'] = type;
    data['mje'] = mje;
    data['Label'] = label;
    data['ZPCount'] = zPCount;
    data['Sum'] = sum;
    data['yhSum'] = yhSum;
    data['IsSatisfy'] = isSatisfy;
    if (zp != null) {
      data['zp'] = zp!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Coupons {
  String? id;
  String? name;
  String? instruction;
  String? money;
  String? useTimeOut;
  String? useExplain;
  String? explain;
  int? isReceived;

  Coupons(
      {this.id,
      this.name,
      this.instruction,
      this.money,
      this.useTimeOut,
      this.useExplain,
      this.explain,
      this.isReceived});

  Coupons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    instruction = json['Instruction'];
    money = json['Money'];
    useTimeOut = json['UseTimeOut'];
    useExplain = json['UseExplain'];
    explain = json['Explain'];
    isReceived = json['IsReceived'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['Instruction'] = instruction;
    data['Money'] = money;
    data['UseTimeOut'] = useTimeOut;
    data['UseExplain'] = useExplain;
    data['Explain'] = explain;
    data['IsReceived'] = isReceived;
    return data;
  }
}

class CartDetail {
  String? label;
  double? value;

  CartDetail({this.label, this.value});

  CartDetail.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = double.parse(json['value']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['value'] = value;
    return data;
  }
}
