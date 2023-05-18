class ProductCategoryModel {
  String? time;
  List<CategoryModel>? list;

  ProductCategoryModel({this.time, this.list});

  ProductCategoryModel.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    if (json['list'] != null) {
      list = <CategoryModel>[];
      json['list'].forEach((v) {
        list!.add(new CategoryModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryModel {
  String? title;
  String? typeid;
  List<CategoryItemModel>? data;
  // List<Data>? data;

  CategoryModel({this.title, this.typeid, this.data});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    typeid = json['typeid'];
    if (json['data'] != null) {
      data = <CategoryItemModel>[];
      json['data'].forEach((v) {
        data!.add(new CategoryItemModel.fromJson(v));
      });
    }
    // if (json['data'] != null) {
    //   data = <Data>[];
    //   json['data'].forEach((v) {
    //     data!.add(new Data.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['typeid'] = this.typeid;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryItemModel {
  String? typeid;
  String? title;
  String? picurl;
  List<CategoryItemDataModel>? data;

  CategoryItemModel({
    this.typeid,
    this.title,
    this.picurl,
  });

  CategoryItemModel.fromJson(Map<String, dynamic> json) {
    typeid = json['typeid'];
    title = json['title'];
    picurl = json['picurl'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(CategoryItemDataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['typeid'] = this.typeid;
    data['title'] = this.title;
    data['picurl'] = this.picurl;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

// class Data {
//   String? typeid;
//   String? title;
//   String? picurl;
//   List<Data>? data;

//   Data({this.typeid, this.title, this.picurl, this.data});

//   Data.fromJson(Map<String, dynamic> json) {
//     typeid = json['typeid'];
//     title = json['title'];
//     picurl = json['picurl'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['typeid'] = this.typeid;
//     data['title'] = this.title;
//     data['picurl'] = this.picurl;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

class CategoryItemDataModel {
  String? typeid;
  String? item;
  String? itemurl;

  CategoryItemDataModel({this.typeid, this.item, this.itemurl});

  CategoryItemDataModel.fromJson(Map<String, dynamic> json) {
    typeid = json['typeid'];
    item = json['item'];
    itemurl = json['itemurl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['typeid'] = this.typeid;
    data['item'] = this.item;
    data['itemurl'] = this.itemurl;
    return data;
  }
}
