import 'package:ttmall/utils/app_extensions.dart';

class ProdetailCommentModel {
  List<CommentModel>? list;
  List<ButtonlistModel>? buttonlist;

  ProdetailCommentModel({this.list, this.buttonlist});

  ProdetailCommentModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <CommentModel>[];
      json['list'].forEach((v) {
        list!.add(CommentModel.fromJson(v));
      });
    }
    if (json['buttonlist'] != null) {
      buttonlist = <ButtonlistModel>[];
      json['buttonlist'].forEach((v) {
        buttonlist!.add(ButtonlistModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    if (this.buttonlist != null) {
      data['buttonlist'] = this.buttonlist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CommentModel {
  String? cid;
  String? cc;
  DateTime? ct;
  double? clevel;
  String? cuser;
  String? cimg;
  DateTime? buytime;
  List<Curls>? curls;

  CommentModel(
      {this.cid,
      this.cc,
      this.ct,
      this.clevel,
      this.cuser,
      this.cimg,
      this.buytime,
      this.curls});

  CommentModel.fromJson(Map<String, dynamic> json) {
    cid = json['cid'];
    cc = json['cc'];
    String ctStr = json['ct'];
    ct = ctStr.stringToDateTime();
    clevel = double.parse(json['clevel']);
    cuser = json['cuser'];
    cimg = json['cimg'];
    String buyTimeStr = json['buytime'];
    buytime = buyTimeStr.stringToDateTime();
    if (json['curls'] != null) {
      curls = <Curls>[];
      json['curls'].forEach((v) {
        curls!.add(new Curls.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cid'] = this.cid;
    data['cc'] = this.cc;
    data['ct'] = this.ct;
    data['clevel'] = this.clevel;
    data['cuser'] = this.cuser;
    data['cimg'] = this.cimg;
    data['buytime'] = this.buytime;
    if (this.curls != null) {
      data['curls'] = this.curls!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Curls {
  String? surl;
  String? burl;

  Curls({this.surl, this.burl});

  Curls.fromJson(Map<String, dynamic> json) {
    surl = json['surl'];
    burl = json['burl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['surl'] = this.surl;
    data['burl'] = this.burl;
    return data;
  }
}

class ButtonlistModel {
  String? name;
  int? type;

  ButtonlistModel({this.name, this.type});

  ButtonlistModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = int.parse(json['type']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['type'] = this.type;
    return data;
  }
}
