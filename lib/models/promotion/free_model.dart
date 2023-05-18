class FreeModel {
  String? label;
  int? count;

  FreeModel({this.label, this.count});

  FreeModel.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['count'] = count;
    return data;
  }
}
