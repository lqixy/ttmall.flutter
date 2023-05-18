class PickAddressModel {
  String? isuse;
  List<PickAddressItemModel>? list;

  PickAddressModel({this.isuse, this.list});

  PickAddressModel.fromJson(Map<String, dynamic> json) {
    isuse = json['isuse'];
    if (json['list'] != null) {
      list = <PickAddressItemModel>[];
      json['list'].forEach((v) {
        list!.add(new PickAddressItemModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isuse'] = this.isuse;
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PickAddressItemModel {
  String? pickid;
  String? pickname;
  String? pickaddress;
  String? pickphone;
  String? remark;
  MapModel? map;
  String? isdefault;
  User? user;

  PickAddressItemModel(
      {this.pickid,
      this.pickname,
      this.pickaddress,
      this.pickphone,
      this.remark,
      this.map,
      this.isdefault,
      this.user});

  PickAddressItemModel.fromJson(Map<String, dynamic> json) {
    pickid = json['pickid'];
    pickname = json['pickname'];
    pickaddress = json['pickaddress'];
    pickphone = json['pickphone'];
    remark = json['remark'];
    map = json['map'] != null ? new MapModel.fromJson(json['map']) : null;
    isdefault = json['isdefault'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pickid'] = this.pickid;
    data['pickname'] = this.pickname;
    data['pickaddress'] = this.pickaddress;
    data['pickphone'] = this.pickphone;
    data['remark'] = this.remark;
    if (this.map != null) {
      data['map'] = this.map!.toJson();
    }
    data['isdefault'] = this.isdefault;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class MapModel {
  String? imgurl;

  MapModel({this.imgurl});

  MapModel.fromJson(Map<String, dynamic> json) {
    imgurl = json['imgurl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imgurl'] = this.imgurl;
    return data;
  }
}

class User {
  String? name;
  String? phone;

  User({this.name, this.phone});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    return data;
  }
}
