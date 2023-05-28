class AddressModel {
  String? addrid;
  String? name;
  String? phone;
  String? idcard;
  String? provid;
  String? cityid;
  String? countyid;
  String? provname;
  String? cityname;
  String? countyname;
  String? addr;
  String? isdefault;

  String get addressDetail => '$provname$cityname$countyname$addr';

  AddressModel(
      {this.addrid,
      this.name,
      this.phone,
      this.idcard,
      this.provid,
      this.cityid,
      this.countyid,
      this.provname,
      this.cityname,
      this.countyname,
      this.addr,
      this.isdefault});

  AddressModel.fromJson(Map<String, dynamic> json) {
    addrid = json['addrid'];
    name = json['name'];
    phone = json['phone'];
    idcard = json['idcard'];
    provid = json['provid'];
    cityid = json['cityid'];
    countyid = json['countyid'];
    provname = json['provname'];
    cityname = json['cityname'];
    countyname = json['countyname'];
    addr = json['addr'];
    isdefault = json['isdefault'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['addrid'] = this.addrid;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['idcard'] = this.idcard;
    data['provid'] = this.provid;
    data['cityid'] = this.cityid;
    data['countyid'] = this.countyid;
    data['provname'] = this.provname;
    data['cityname'] = this.cityname;
    data['countyname'] = this.countyname;
    data['addr'] = this.addr;
    data['isdefault'] = this.isdefault;
    return data;
  }
}
