class HotRecommendModel {
  List<HotRecommendItemModel>? list;

  HotRecommendModel({this.list});

  HotRecommendModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <HotRecommendItemModel>[];
      json['list'].forEach((v) {
        list!.add(new HotRecommendItemModel.fromJson(v));
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

class HotRecommendItemModel {
  String? iconurl;
  String? title;
  Action? action;

  HotRecommendItemModel({this.iconurl, this.title, this.action});

  HotRecommendItemModel.fromJson(Map<String, dynamic> json) {
    iconurl = json['iconurl'];
    title = json['title'];
    action =
        json['action'] != null ? new Action.fromJson(json['action']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['iconurl'] = this.iconurl;
    data['title'] = this.title;
    if (this.action != null) {
      data['action'] = this.action!.toJson();
    }
    return data;
  }
}

class Action {
  String? type;
  String? link;
  String? parameter;

  Action({this.type, this.link, this.parameter});

  Action.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    link = json['link'];
    parameter = json['parameter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['link'] = this.link;
    data['parameter'] = this.parameter;
    return data;
  }
}
