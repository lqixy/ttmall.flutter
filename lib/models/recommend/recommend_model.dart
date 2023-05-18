// ignore_for_file: unnecessary_this

import 'package:ttmall/utils/app_extensions.dart';

class RecommendModel {
  String? placename;
  String? outputargs;
  List<RecommendItemModel>? list;

  RecommendModel({this.placename, this.outputargs, this.list});

  RecommendModel.fromJson(Map<String, dynamic> json) {
    placename = json['placename'];
    outputargs = json['outputargs'];
    if (json['list'] != null) {
      list = <RecommendItemModel>[];
      json['list'].forEach((v) {
        list!.add(RecommendItemModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['placename'] = placename;
    data['outputargs'] = outputargs;
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RecommendItemModel {
  String? args;
  String? click;
  String? cmtcount;
  String? goodcmtcount;
  String? goodsid;
  String? video;
  String? intro;
  String? link;
  String? modetrade;
  String? originalprice;
  String? pic;
  String? sales;
  String? sellprice;
  int? stock;
  List<String>? label;
  String? title;
  String? other;
  String? brandname;
  String? brandlogo;

  RecommendItemModel(
      {this.args,
      this.click,
      this.cmtcount,
      this.goodcmtcount,
      this.goodsid,
      this.video,
      this.intro,
      this.link,
      this.modetrade,
      this.originalprice,
      this.pic,
      this.sales,
      this.sellprice,
      this.stock,
      this.label,
      this.title,
      this.other,
      this.brandname,
      this.brandlogo});

  RecommendItemModel.fromJson(Map<String, dynamic> json) {
    args = json['args'];
    click = json['click'];
    cmtcount = json['cmtcount'];
    goodcmtcount = json['goodcmtcount'];
    goodsid = json['goodsid'];
    video = json['video'];
    intro = json['intro'];
    link = json['link'];
    modetrade = json['modetrade'];
    originalprice = json['originalprice'];
    pic = json['pic'];
    sales = json['sales'];
    sellprice = json['sellprice'];
    String stockStr = json['stock'];
    stock = stockStr.convertToInt();
    label = json['label'].cast<String>();
    title = json['title'];
    other = json['other'];
    brandname = json['brandname'];
    brandlogo = json['brandlogo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['args'] = this.args;
    data['click'] = this.click;
    data['cmtcount'] = this.cmtcount;
    data['goodcmtcount'] = this.goodcmtcount;
    data['goodsid'] = this.goodsid;
    data['video'] = this.video;
    data['intro'] = this.intro;
    data['link'] = this.link;
    data['modetrade'] = this.modetrade;
    data['originalprice'] = this.originalprice;
    data['pic'] = this.pic;
    data['sales'] = this.sales;
    data['sellprice'] = this.sellprice;
    data['stock'] = this.stock;
    data['label'] = this.label;
    data['title'] = this.title;
    data['other'] = this.other;
    data['brandname'] = this.brandname;
    data['brandlogo'] = this.brandlogo;
    return data;
  }
}
