class ProductInfoModel {
  String? sequence;
  String? productid;
  String? goodsid;
  String? commission;
  String? goodstype;
  String? iscanbuy;
  String? goodsname;
  String? goodsrecordname;
  String? goodsdesc;
  String? goodstradestate;
  String? goodsactivity;
  Predictinfo? predictinfo;
  String? taxes;
  String? ishowinvite;
  String? placedelivery;
  String? purchasenum;
  String? praiserate;
  String? stock;
  String? oncebuylimit;
  String? time;
  List<Goodsurl>? goodsurl;
  List<Goodsstandard>? goodsstandard;
  Goodsbrand? goodsbrand;
  int? showshops;
  String? shopsid;
  int? iscoupon;
  String? video;
  String? buyflow;

  ProductInfoModel(
      {this.sequence,
      this.productid,
      this.goodsid,
      this.commission,
      this.goodstype,
      this.iscanbuy,
      this.goodsname,
      this.goodsrecordname,
      this.goodsdesc,
      this.goodstradestate,
      this.goodsactivity,
      this.predictinfo,
      this.taxes,
      this.ishowinvite,
      this.placedelivery,
      this.purchasenum,
      this.praiserate,
      this.stock,
      this.oncebuylimit,
      this.time,
      this.goodsurl,
      this.goodsstandard,
      this.goodsbrand,
      this.showshops,
      this.shopsid,
      this.iscoupon,
      this.video,
      this.buyflow});

  ProductInfoModel.fromJson(Map<String, dynamic> json) {
    sequence = json['sequence'];
    productid = json['productid'];
    goodsid = json['goodsid'];
    commission = json['commission'];
    goodstype = json['goodstype'];
    iscanbuy = json['iscanbuy'];
    goodsname = json['goodsname'];
    goodsrecordname = json['goodsrecordname'];
    goodsdesc = json['goodsdesc'];
    goodstradestate = json['goodstradestate'];
    goodsactivity = json['goodsactivity'];
    predictinfo = json['predictinfo'] != null
        ? new Predictinfo.fromJson(json['predictinfo'])
        : null;
    taxes = json['taxes'];
    ishowinvite = json['ishowinvite'];
    placedelivery = json['placedelivery'];
    purchasenum = json['purchasenum'];
    praiserate = json['praiserate'];
    stock = json['stock'];
    oncebuylimit = json['oncebuylimit'];
    time = json['time'];
    if (json['goodsurl'] != null) {
      goodsurl = <Goodsurl>[];
      json['goodsurl'].forEach((v) {
        goodsurl!.add(new Goodsurl.fromJson(v));
      });
    }
    if (json['goodsstandard'] != null) {
      goodsstandard = <Goodsstandard>[];
      json['goodsstandard'].forEach((v) {
        goodsstandard!.add(new Goodsstandard.fromJson(v));
      });
    }
    goodsbrand = json['goodsbrand'] != null
        ? new Goodsbrand.fromJson(json['goodsbrand'])
        : null;
    showshops = json['showshops'];
    shopsid = json['shopsid'];
    iscoupon = json['iscoupon'];
    video = json['video'];
    buyflow = json['buyflow'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sequence'] = this.sequence;
    data['productid'] = this.productid;
    data['goodsid'] = this.goodsid;
    data['commission'] = this.commission;
    data['goodstype'] = this.goodstype;
    data['iscanbuy'] = this.iscanbuy;
    data['goodsname'] = this.goodsname;
    data['goodsrecordname'] = this.goodsrecordname;
    data['goodsdesc'] = this.goodsdesc;
    data['goodstradestate'] = this.goodstradestate;
    data['goodsactivity'] = this.goodsactivity;
    if (this.predictinfo != null) {
      data['predictinfo'] = this.predictinfo!.toJson();
    }
    data['taxes'] = this.taxes;
    data['ishowinvite'] = this.ishowinvite;
    data['placedelivery'] = this.placedelivery;
    data['purchasenum'] = this.purchasenum;
    data['praiserate'] = this.praiserate;
    data['stock'] = this.stock;
    data['oncebuylimit'] = this.oncebuylimit;
    data['time'] = this.time;
    if (this.goodsurl != null) {
      data['goodsurl'] = this.goodsurl!.map((v) => v.toJson()).toList();
    }
    if (this.goodsstandard != null) {
      data['goodsstandard'] =
          this.goodsstandard!.map((v) => v.toJson()).toList();
    }
    if (this.goodsbrand != null) {
      data['goodsbrand'] = this.goodsbrand!.toJson();
    }
    data['showshops'] = this.showshops;
    data['shopsid'] = this.shopsid;
    data['iscoupon'] = this.iscoupon;
    data['video'] = this.video;
    data['buyflow'] = this.buyflow;
    return data;
  }
}

class Predictinfo {
  String? predictstarttime;
  String? predictendtime;
  String? overtime;
  String? price;
  String? finalprice;
  String? finaltime;
  String? second;

  Predictinfo(
      {this.predictstarttime,
      this.predictendtime,
      this.overtime,
      this.price,
      this.finalprice,
      this.finaltime,
      this.second});

  Predictinfo.fromJson(Map<String, dynamic> json) {
    predictstarttime = json['predictstarttime'];
    predictendtime = json['predictendtime'];
    overtime = json['overtime'];
    price = json['price'];
    finalprice = json['finalprice'];
    finaltime = json['finaltime'];
    second = json['second'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['predictstarttime'] = this.predictstarttime;
    data['predictendtime'] = this.predictendtime;
    data['overtime'] = this.overtime;
    data['price'] = this.price;
    data['finalprice'] = this.finalprice;
    data['finaltime'] = this.finaltime;
    data['second'] = this.second;
    return data;
  }
}

class Goodsurl {
  String? url;

  Goodsurl({this.url});

  Goodsurl.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    return data;
  }
}

class Goodsstandard {
  String? gid;

  String? isattention;
  int? stock;
  String? ishowstock;
  String? price;
  String? productcodenum;
  String? marketprice;
  String? purchasenum;
  String? goodsstate;
  String? deliveryprice;
  String? ourprice;
  String? mainimage;
  String? goodsname;
  String? xg;
  String? inviteprice;

  Goodsstandard({
    this.gid,
    this.isattention,
    this.stock,
    this.ishowstock,
    this.price,
    this.productcodenum,
    this.marketprice,
    this.purchasenum,
    this.goodsstate,
    this.deliveryprice,
    this.ourprice,
    this.mainimage,
    this.goodsname,
    this.xg,
    this.inviteprice,
  });

  Goodsstandard.fromJson(Map<String, dynamic> json) {
    gid = json['gid'];

    isattention = json['isattention'];

    stock = int.parse(json['stock']);
    ishowstock = json['ishowstock'];
    price = json['price'];
    productcodenum = json['productcodenum'];
    marketprice = json['marketprice'];
    purchasenum = json['purchasenum'];
    goodsstate = json['goodsstate'];
    deliveryprice = json['deliveryprice'];
    ourprice = json['ourprice'];
    mainimage = json['mainimage'];
    goodsname = json['goodsname'];
    xg = json['xg'];
    inviteprice = json['inviteprice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gid'] = this.gid;

    data['isattention'] = this.isattention;
    data['stock'] = this.stock;
    data['ishowstock'] = this.ishowstock;
    data['price'] = this.price;
    data['productcodenum'] = this.productcodenum;
    data['marketprice'] = this.marketprice;
    data['purchasenum'] = this.purchasenum;
    data['goodsstate'] = this.goodsstate;
    data['deliveryprice'] = this.deliveryprice;
    data['ourprice'] = this.ourprice;
    data['mainimage'] = this.mainimage;
    data['goodsname'] = this.goodsname;
    data['xg'] = this.xg;
    data['inviteprice'] = this.inviteprice;

    return data;
  }
}

class Goodsbrand {
  String? brandid;
  String? brandname;
  String? country;
  String? branddescription;
  String? brandurl;
  String? countryimg;

  Goodsbrand(
      {this.brandid,
      this.brandname,
      this.country,
      this.branddescription,
      this.brandurl,
      this.countryimg});

  Goodsbrand.fromJson(Map<String, dynamic> json) {
    brandid = json['brandid'];
    brandname = json['brandname'];
    country = json['country'];
    branddescription = json['branddescription'];
    brandurl = json['brandurl'];
    countryimg = json['countryimg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brandid'] = this.brandid;
    data['brandname'] = this.brandname;
    data['country'] = this.country;
    data['branddescription'] = this.branddescription;
    data['brandurl'] = this.brandurl;
    data['countryimg'] = this.countryimg;
    return data;
  }
}
