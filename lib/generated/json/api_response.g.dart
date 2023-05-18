import 'package:ttmall/generated/json/base/json_convert_content.dart';
import 'package:ttmall/models/api/api_response.dart';

ApiResponse<T> $ApiResponseFromJson<T>(Map<String, dynamic> json) {
  final ApiResponse<T> apiResponse = ApiResponse<T>();
  final int? code = jsonConvert.convert<int>(json['code']);
  if (code != null) {
    apiResponse.code = code;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    apiResponse.msg = msg;
  }
  final T? data = jsonConvert.convert<T>(json['data']);
  if (data != null) {
    apiResponse.data = data;
  }
  // final ApiResponseData? data =
  //     jsonConvert.convert<ApiResponseData>(json['data']);
  // if (data != null) {
  //   apiResponse.data = data;
  // }
  return apiResponse;
}

Map<String, dynamic> $ApiResponseToJson(ApiResponse entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['msg'] = entity.msg;
  data['data'] = entity.data?.toJson();
  return data;
}
//
// ApiResponseData $ApiResponseDataFromJson(Map<String, dynamic> json) {
//   final ApiResponseData apiResponseData = ApiResponseData();
//   return apiResponseData;
// }
//
// Map<String, dynamic> $ApiResponseDataToJson(ApiResponseData entity) {
//   final Map<String, dynamic> data = <String, dynamic>{};
//   return data;
// }
