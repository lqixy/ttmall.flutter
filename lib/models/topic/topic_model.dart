import 'package:ttmall/utils/app_extensions.dart';

class TopicModel {
  List<String>? type;
  String? topicTitle;
  String? keyword;
  String? desc;
  String? istag;
  String? posterimg;
  String? icon;
  String? pagecolor;
  String? sharetitle;
  String? shareds;
  String? layouttype;
  String? shareimg;
  List<Topictag>? topictag;

  TopicModel(
      {this.type,
      this.topicTitle,
      this.keyword,
      this.desc,
      this.istag,
      this.posterimg,
      this.icon,
      this.pagecolor,
      this.sharetitle,
      this.shareds,
      this.layouttype,
      this.shareimg,
      this.topictag});

  TopicModel.fromJson(Map<String, dynamic> json) {
    type = json['type'].cast<String>();
    topicTitle = json['topic_title'];
    keyword = json['keyword'];
    desc = json['desc'];
    istag = json['istag'];
    posterimg = json['posterimg'];
    icon = json['icon'];
    pagecolor = json['pagecolor'];
    sharetitle = json['sharetitle'];
    shareds = json['shareds'];
    layouttype = json['layouttype'];
    shareimg = json['shareimg'];
    if (json['topictag'] != null) {
      topictag = <Topictag>[];
      json['topictag'].forEach((v) {
        topictag!.add(Topictag.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['topic_title'] = topicTitle;
    data['keyword'] = keyword;
    data['desc'] = desc;
    data['istag'] = istag;
    data['posterimg'] = posterimg;
    data['icon'] = icon;
    data['pagecolor'] = pagecolor;
    data['sharetitle'] = sharetitle;
    data['shareds'] = shareds;
    data['layouttype'] = layouttype;
    data['shareimg'] = shareimg;
    if (topictag != null) {
      data['topictag'] = topictag!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Topictag {
  String? tagname;
  String? tagimg;
  String? tagaction;
  String? tagtproductimg;
  List<Productlist>? productlist;

  Topictag(
      {this.tagname,
      this.tagimg,
      this.tagaction,
      this.tagtproductimg,
      this.productlist});

  Topictag.fromJson(Map<String, dynamic> json) {
    tagname = json['tagname'];
    tagimg = json['tagimg'];
    tagaction = json['tagaction'];
    tagtproductimg = json['tagtproductimg'];
    if (json['productlist'] != null) {
      productlist = <Productlist>[];
      json['productlist'].forEach((v) {
        productlist!.add(Productlist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tagname'] = tagname;
    data['tagimg'] = tagimg;
    data['tagaction'] = tagaction;
    data['tagtproductimg'] = tagtproductimg;
    if (productlist != null) {
      data['productlist'] = productlist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Productlist {
  String? goodsid;
  String? goodsurl;
  String? goodsname;
  String? goodsdesc;
  String? sellprice;
  String? showprice;
  int? stock;
  String? orignprice;
  String? purchasenum;
  String? goodstradestate;
  String? praiserate;
  List<String>? label;

  Productlist(
      {this.goodsid,
      this.goodsurl,
      this.goodsname,
      this.goodsdesc,
      this.sellprice,
      this.showprice,
      this.stock,
      this.orignprice,
      this.purchasenum,
      this.goodstradestate,
      this.praiserate,
      this.label});

  Productlist.fromJson(Map<String, dynamic> json) {
    goodsid = json['goodsid'];
    goodsurl = json['goodsurl'];
    goodsname = json['goodsname'];
    goodsdesc = json['goodsdesc'];
    sellprice = json['sellprice'];
    showprice = json['showprice'];
    String stockStr = json['stock'];
    stock = stockStr.convertToInt();
    orignprice = json['orignprice'];
    purchasenum = json['purchasenum'];
    goodstradestate = json['goodstradestate'];
    praiserate = json['praiserate'];
    label = json['label'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['goodsid'] = goodsid;
    data['goodsurl'] = goodsurl;
    data['goodsname'] = goodsname;
    data['goodsdesc'] = goodsdesc;
    data['sellprice'] = sellprice;
    data['showprice'] = showprice;
    data['stock'] = stock;
    data['orignprice'] = orignprice;
    data['purchasenum'] = purchasenum;
    data['goodstradestate'] = goodstradestate;
    data['praiserate'] = praiserate;
    data['label'] = label;
    return data;
  }
}
