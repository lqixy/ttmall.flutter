class AddressModel {
  String? addrid;
  String? name;
  String? phone;
  String? addr;
  String? idcard;
  String? rim;
  String? isdefault;

  AddressModel(
      {this.addrid,
      this.name,
      this.phone,
      this.addr,
      this.idcard,
      this.rim,
      this.isdefault});

  AddressModel.fromJson(Map<String, dynamic> json) {
    addrid = json['addrid'];
    name = json['name'];
    phone = json['phone'];
    addr = json['addr'];
    idcard = json['idcard'];
    rim = json['rim'];
    isdefault = json['isdefault'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['addrid'] = this.addrid;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['addr'] = this.addr;
    data['idcard'] = this.idcard;
    data['rim'] = this.rim;
    data['isdefault'] = this.isdefault;
    return data;
  }
}
