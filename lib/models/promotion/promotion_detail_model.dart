import 'free_model.dart';

class PromotionDetailModel {
  List<Tc>? tc;
  List<Nyrxg>? nyrxg;
  List<Mjz>? mjz;

  PromotionDetailModel({this.tc, this.nyrxg, this.mjz});

  PromotionDetailModel.fromJson(Map<String, dynamic> json) {
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
  List<PromotionGoodsModel>? zp;

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
      zp = <PromotionGoodsModel>[];
      json['zp'].forEach((v) {
        zp!.add(PromotionGoodsModel.fromJson(v));
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

class PromotionGoodsModel {
  String? type;
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

  PromotionGoodsModel(
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

  PromotionGoodsModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    ischeck = json['ischeck'] == '1';
    entryid = json['entryid'];
    hasentryid = json['hasentryid'].cast<String>();
    itemid = json['itemid'];

    purchasenum = int.parse(json['purchasenum']);
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
    stock = int.parse(json['stock']);
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
