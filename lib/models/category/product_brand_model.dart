class ProductBrandModel {
  List<ProductBrandItemModel>? list;

  ProductBrandModel({this.list});

  ProductBrandModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <ProductBrandItemModel>[];
      json['list'].forEach((v) {
        list!.add(new ProductBrandItemModel.fromJson(v));
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

class ProductBrandItemModel {
  String? title;
  String? titleid;
  List<ProductBrandDataItemModel>? data;

  ProductBrandItemModel({this.title, this.titleid, this.data});

  ProductBrandItemModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    titleid = json['titleid'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(new ProductBrandDataItemModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['titleid'] = this.titleid;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductBrandDataItemModel {
  String? brandid;
  String? brand;
  String? iconurl;
  String? initial;

  ProductBrandDataItemModel(
      {this.brandid, this.brand, this.iconurl, this.initial});

  ProductBrandDataItemModel.fromJson(Map<String, dynamic> json) {
    brandid = json['brandid'];
    brand = json['brand'];
    iconurl = json['iconurl'];
    initial = json['initial'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brandid'] = this.brandid;
    data['brand'] = this.brand;
    data['iconurl'] = this.iconurl;
    data['initial'] = this.initial;
    return data;
  }
}
