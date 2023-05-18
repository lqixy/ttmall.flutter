import 'package:dio/dio.dart';
import 'package:ttmall/models/api/api_response.dart';
import 'package:ttmall/utils/request_config.dart';

RequestClient requestClient = RequestClient();

class RequestClient {
  late Dio _dio;

  RequestClient() {
    _dio = Dio(BaseOptions(
      baseUrl: RequestConfig.baseUrl,
    ));
  }

  Future<T> request<T>(String url,
      {String method = 'POST',
      Map<String, dynamic>? parameters,
      data,
      Map<String, dynamic>? headers}) async {
    Options options = Options()
      ..method = method
      ..headers = headers;
    Response response = await _dio.request(url,
        queryParameters: parameters, data: data, options: options);

    return response.data;
  }

  T? _handleResponse<T>(Response response) {
    if (response.statusCode == 200) {
      ApiResponse<T> apiResponse = ApiResponse.fromJson(response.data);
      return _handleBusinessResponse(apiResponse);
    } else {
      return null;
    }
  }

  T? _handleBusinessResponse<T>(ApiResponse<T> response) {
    if (response.code == 1100) {
      return response.data;
    } else {
      return null;
    }
  }
}
