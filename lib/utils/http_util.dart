import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ttmall/interceptors/error_interceptor.dart';
import 'package:ttmall/models/api/api_response.dart';
import 'package:ttmall/models/api/request/api_request.dart';
import 'package:ttmall/utils/request_config.dart';

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
    var headers = <String, dynamic>{
      'Authorization': 'Bearer ${RequestConfig.ttmallToken}'
    };
    options.headers.addAll(headers);
    // options.headers['Authorization'] = 'Bearer ${RequestConfig.ttmallToken}';

    dio = Dio(options);
    dio.interceptors.add(ErrorInterceptor());
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

  // Future get(String endpoint) async {
  //   var response = await dio.get(endpoint);
  //   return response;
  // }

  // Future post(String endpoint, ApiRequest input) async {
  //   // var queryParameters = json.encode(input);
  //   Uri.parse(endpoint).replace(queryParameters: input.toJson());
  // }
}
