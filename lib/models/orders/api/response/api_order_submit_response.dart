class ApiOrderSubmitResponse {
  List<ApiOrderSubmitItem>? list;

  ApiOrderSubmitResponse({this.list});

  ApiOrderSubmitResponse.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <ApiOrderSubmitItem>[];
      json['list'].forEach((v) {
        list!.add(new ApiOrderSubmitItem.fromJson(v));
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

class ApiOrderSubmitItem {
  String? orderno;
  List<ApiOrderSubmitItemSettlement>? list;

  ApiOrderSubmitItem({this.orderno, this.list});

  ApiOrderSubmitItem.fromJson(Map<String, dynamic> json) {
    orderno = json['orderno'];
    if (json['list'] != null) {
      list = <ApiOrderSubmitItemSettlement>[];
      json['list'].forEach((v) {
        list!.add(new ApiOrderSubmitItemSettlement.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderno'] = this.orderno;
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ApiOrderSubmitItemSettlement {
  String? orderid;

  ApiOrderSubmitItemSettlement({this.orderid});

  ApiOrderSubmitItemSettlement.fromJson(Map<String, dynamic> json) {
    orderid = json['orderid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderid'] = this.orderid;
    return data;
  }
}


// class ApiOrderSubmitItem{

// }

// class ApiOrderSubmitItemSettlement{

// }