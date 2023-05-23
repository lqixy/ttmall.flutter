class ApiResponse<T> {
  int? code;
  String? msg;
  T data;

  bool get success => code == 1100;

  ApiResponse({
    required this.code,
    required this.msg,
    required this.data,
  });
}

class ApiResponseV2 {
  int? code = 4400;
  String? msg = '';
  dynamic data;

  bool get success => code == 1100;

  ApiResponseV2();

  ApiResponseV2.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    data['data'] = data;
    return data;
  }
}

//
// @JsonSerializable()
// class ApiResponseData {
//   ApiResponseData();
//
//   factory ApiResponseData.fromJson(Map<String, dynamic> json) =>
//       $ApiResponseDataFromJson(json);
//
//   Map<String, dynamic> toJson() => $ApiResponseDataToJson(this);
//
//   @override
//   String toString() {
//     return jsonEncode(this);
//   }
// }
