import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ttmall/interceptors/connectivity_interceptor.dart';
import 'package:ttmall/interceptors/error_interceptor.dart';
import 'package:ttmall/models/api/api_response.dart';
import 'package:ttmall/models/api/request/api_request.dart';
import 'package:ttmall/services/jsp_util.dart';
import 'package:ttmall/utils/app_friendly_exception.dart';
import 'package:ttmall/utils/request_config.dart';
import 'package:ttmall/utils/uidata.dart';

class HttpUtil {
  static final HttpUtil _instance = HttpUtil._internal();
  late Dio dio;

  factory HttpUtil() {
    return _instance;
  }

  HttpUtil._internal() {
    BaseOptions options = BaseOptions()
      ..baseUrl = RequestConfig.baseUrl
      ..connectTimeout = const Duration(seconds: 3)
      ..contentType = 'application/json: charset=utf-8'
      ..responseType = ResponseType.json;
    var authToken = JSpUtil.instance.getString(UIData.authToken);
    var token = authToken == null || authToken.isEmpty
        ? RequestConfig.ttmallToken
        : authToken;
    var headers = <String, dynamic>{'Authorization': 'Bearer $token'};
    options.headers.addAll(headers);
    // options.headers['Authorization'] = 'Bearer ${RequestConfig.ttmallToken}';

    dio = Dio(options);
    // dio.interceptors.add(ConnectivityInterceptor());
    // dio.interceptors.add(ErrorInterceptor());
  }

  Future<ApiResponseV2> getAsync(String endpoint, {ApiRequest? input}) async {
    ApiResponseV2 result = ApiResponseV2();
    try {
      input ??= ApiRequest();
      var uri = Uri.parse(endpoint).replace(queryParameters: input.toJson());
      var url = uri.toString();

      var response = await dio.get(url);
      if (response.statusCode == 200) {
        return ApiResponseV2.fromJson(response.data);
      } else {
        return result;
      }
    } on AppFriendlyException catch (e) {
      print(e.message);
      result.msg = e.message;
      return result;
    } catch (e) {
      print(e.toString());
      return result;
      // return result;
    }
  }

  Future<ApiResponseV2> postAsync(String endpoint, ApiRequest input) async {
    ApiResponseV2 result = ApiResponseV2();

    try {
      var data = jsonEncode(input.toJson());
      var response = await dio.post(endpoint,
          data: data, options: Options(contentType: Headers.jsonContentType));
      if (response.statusCode == 200) {
        return ApiResponseV2.fromJson(response.data);
      } else {
        return result;
      }
    } catch (e) {
      return result;
    }
  }

  // Future<ApiResponse<T?>> get<T>(String endpoint,ApiRequest? request)async{
  //   var token = JSpUtil.instance.getString(UIData.authToken);
  //   request ??= ApiRequest();
  //   var uri = Uri.parse(endpoint).replace(queryParameters: request.toJson());
  //   var url = uri.toString();

  //   var response = await dio.get(url);

  // }

  // ApiResponse<T?> processResponse<T>(Response<dynamic> response){
  //   try {
  //     var jsonResult = response.data;
  //     var output = ApiResponse<T?>(code: jsonResult['code'],
  //     msg: jsonResult['msg'],
  //     data: jsonResult['data']
  //     );
  //   } catch (e) {
  //     return ApiResponse<T?>(code: 4400, msg: '', data: null);
  //   }
  // }
}
