class ApiOrderComputeResponse {
  String? needidcard;
  String? orderno;
  String? paystatus;
  String? total;
  List<ApiOrderComputeItemSettlement>? list;
  List<ApiOrderComputeDetail>? detail;

  ApiOrderComputeResponse(
      {this.needidcard,
      this.orderno,
      this.paystatus,
      this.total,
      this.list,
      this.detail});

  ApiOrderComputeResponse.fromJson(Map<String, dynamic> json) {
    needidcard = json['needidcard'];
    orderno = json['orderno'];
    paystatus = json['paystatus'];
    total = json['total'];
    if (json['list'] != null) {
      list = <ApiOrderComputeItemSettlement>[];
      json['list'].forEach((v) {
        list!.add(new ApiOrderComputeItemSettlement.fromJson(v));
      });
    }
    if (json['detail'] != null) {
      detail = <ApiOrderComputeDetail>[];
      json['detail'].forEach((v) {
        detail!.add(new ApiOrderComputeDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['needidcard'] = this.needidcard;
    data['orderno'] = this.orderno;
    data['paystatus'] = this.paystatus;
    data['total'] = this.total;
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    if (this.detail != null) {
      data['detail'] = this.detail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ApiOrderComputeItemSettlement {
  String? ordersettlementid;

  ApiOrderComputeItemSettlement({this.ordersettlementid});

  ApiOrderComputeItemSettlement.fromJson(Map<String, dynamic> json) {
    ordersettlementid = json['ordersettlementid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ordersettlementid'] = this.ordersettlementid;
    return data;
  }
}

class ApiOrderComputeDetail {
  String? label;
  String? value;

  ApiOrderComputeDetail({this.label, this.value});

  ApiOrderComputeDetail.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['value'] = this.value;
    return data;
  }
}
