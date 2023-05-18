class ProductInfoRecommendGoodsModel {
  List<GoodsModel>? list;
  ProductInfoRecommendGoodsModel({this.list});

  ProductInfoRecommendGoodsModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <GoodsModel>[];
      json['list'].forEach((v) {
        list!.add(new GoodsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GoodsModel {
  String? goodsid;
  String? goodsurl;
  String? goodsname;
  String? goodsdesc;
  String? sellprice;
  String? orignprice;
  String? purchasenum;
  String? praiserate;
  String? placedelivery;
  int? stock;
  List<String>? label;

  GoodsModel(
      {this.goodsid,
      this.goodsurl,
      this.goodsname,
      this.goodsdesc,
      this.sellprice,
      this.orignprice,
      this.purchasenum,
      this.praiserate,
      this.placedelivery,
      this.stock,
      this.label});

  GoodsModel.fromJson(Map<String, dynamic> json) {
    goodsid = json['goodsid'];
    goodsurl = json['goodsurl'];
    goodsname = json['goodsname'];
    goodsdesc = json['goodsdesc'];
    sellprice = json['sellprice'];
    orignprice = json['orignprice'];
    purchasenum = json['purchasenum'];
    praiserate = json['praiserate'];
    placedelivery = json['placedelivery'];
    stock = int.parse(json['stock']);
    label = json['label'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['goodsid'] = this.goodsid;
    data['goodsurl'] = this.goodsurl;
    data['goodsname'] = this.goodsname;
    data['goodsdesc'] = this.goodsdesc;
    data['sellprice'] = this.sellprice;
    data['orignprice'] = this.orignprice;
    data['purchasenum'] = this.purchasenum;
    data['praiserate'] = this.praiserate;
    data['placedelivery'] = this.placedelivery;
    data['stock'] = this.stock;
    data['label'] = this.label;
    return data;
  }
}
