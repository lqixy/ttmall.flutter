import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
// import 'package:ttmall/services/store.dart';
import 'package:ttmall/utils/request_config.dart';

class HttpService {
  late Dio _dio;

  HttpService() {
    _dio = Dio(BaseOptions(baseUrl: RequestConfig.baseUrl));
    initializeInterceptors();
  }

  Future<Response?> get(String url) async {
    Response? response;
    try {
      response = await _dio.get(url);
    } catch (e) {
      print(e.toString());
    }
    return response;
  }

  initializeInterceptors() {
    // var store = GetIt.instance.get<Store>();
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // var token = await store.getToken();
        // if (token == null) {
        //   await store.setToken(RequestConfig.ttmallToken);
        // }
        options.headers['Authorization'] =
            'Bearer ${RequestConfig.ttmallToken}';
      },
      onError: (e, handler) {
        print(e.message);
      },
      onResponse: (response, handler) {
        print(response.data);
      },
    ));
  }
}

// class CustomInterceptor extends Interceptor{

//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     var token = Store.getToken();
//     options.headers["Authorization"] = 'Basic $token';
//     super.onRequest(options, handler);
//   }
  

// }