class ReceiptServiceModel {
  String? addr;
  String? addrid;
  String? detail;
  List<ServiceModel>? service;

  ReceiptServiceModel({this.addr, this.addrid, this.detail, this.service});

  ReceiptServiceModel.fromJson(Map<String, dynamic> json) {
    addr = json['addr'];
    addrid = json['addrid'];
    detail = json['detail'];
    if (json['service'] != null) {
      service = <ServiceModel>[];
      json['service'].forEach((v) {
        service!.add(new ServiceModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['addr'] = this.addr;
    data['addrid'] = this.addrid;
    data['detail'] = this.detail;
    if (this.service != null) {
      data['service'] = this.service!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServiceModel {
  String? title;
  String? desc;
  String? icon;

  ServiceModel({this.title, this.desc, this.icon});

  ServiceModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    desc = json['desc'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['icon'] = this.icon;
    return data;
  }
}
