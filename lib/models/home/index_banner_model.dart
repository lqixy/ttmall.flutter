class IndexBannerModel {
  List<Adlist>? adlist;
  List<Menulist>? menulist;
  List<Noticelist>? noticelist;
  String? adtime;
  String? menutime;
  String? noticetime;
  String? showtime;

  IndexBannerModel(
      {this.adlist,
      this.menulist,
      this.noticelist,
      this.adtime,
      this.menutime,
      this.noticetime,
      this.showtime});

  IndexBannerModel.fromJson(Map<String, dynamic> json) {
    if (json['adlist'] != null) {
      adlist = <Adlist>[];
      json['adlist'].forEach((v) {
        adlist!.add(new Adlist.fromJson(v));
      });
    }
    if (json['menulist'] != null) {
      menulist = <Menulist>[];
      json['menulist'].forEach((v) {
        menulist!.add(new Menulist.fromJson(v));
      });
    }
    if (json['noticelist'] != null) {
      noticelist = <Noticelist>[];
      json['noticelist'].forEach((v) {
        noticelist!.add(new Noticelist.fromJson(v));
      });
    }
    adtime = json['adtime'];
    menutime = json['menutime'];
    noticetime = json['noticetime'];
    showtime = json['showtime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.adlist != null) {
      data['adlist'] = this.adlist!.map((v) => v.toJson()).toList();
    }
    if (this.menulist != null) {
      data['menulist'] = this.menulist!.map((v) => v.toJson()).toList();
    }
    if (this.noticelist != null) {
      data['noticelist'] = this.noticelist!.map((v) => v.toJson()).toList();
    }
    data['adtime'] = this.adtime;
    data['menutime'] = this.menutime;
    data['noticetime'] = this.noticetime;
    data['showtime'] = this.showtime;
    return data;
  }
}

class Adlist {
  String? picurl;
  String? sort;
  Link? link;

  Adlist({this.picurl, this.sort, this.link});

  Adlist.fromJson(Map<String, dynamic> json) {
    picurl = json['picurl'];
    sort = json['sort'];
    link = json['link'] != null ? new Link.fromJson(json['link']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['picurl'] = this.picurl;
    data['sort'] = this.sort;
    if (this.link != null) {
      data['link'] = this.link!.toJson();
    }
    return data;
  }
}

class Link {
  String? type;
  String? link;
  String? parameter;

  Link({this.type, this.link, this.parameter});

  Link.fromJson(Map<String, dynamic> json) {
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

class Menulist {
  String? icon;
  String? menu;
  String? sort;
  String? isshow;
  Link? link;

  Menulist({this.icon, this.menu, this.sort, this.isshow, this.link});

  Menulist.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    menu = json['menu'];
    sort = json['sort'];
    isshow = json['isshow'];
    link = json['link'] != null ? new Link.fromJson(json['link']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icon'] = this.icon;
    data['menu'] = this.menu;
    data['sort'] = this.sort;
    data['isshow'] = this.isshow;
    if (this.link != null) {
      data['link'] = this.link!.toJson();
    }
    return data;
  }
}

class Noticelist {
  String? title;
  Link? link;

  Noticelist({this.title, this.link});

  Noticelist.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    link = json['link'] != null ? new Link.fromJson(json['link']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.link != null) {
      data['link'] = this.link!.toJson();
    }
    return data;
  }
}
