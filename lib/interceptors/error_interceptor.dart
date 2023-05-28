import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ttmall/utils/app_friendly_exception.dart';

// class ErrorInterceptor extends Interceptor {
//   @override
//   void onError(DioError err, ErrorInterceptorHandler handler) async {
//     Future<bool> isConnected() async {
//       var connectivityResult = await Connectivity().checkConnectivity();
//       return connectivityResult != ConnectivityResult.none;
//     }

//     if (err.type == DioErrorType.unknown) {
//       var isConnectNetWork = await isConnected();
//       if (!isConnectNetWork) {
//         // err.copyWith(message: '当前网络不可用，请检查您的网络.');
//         // throw AppFriendlyException('当前网络不可用，请检查您的网络.');
//         // err.copyWith(error: MyDioSocketException('当前网络不可用，请检查您的网络.'));
//       }
//       // print(err.message);
//       handler.next(err);
//       // err.error
//     }
//     super.onError(err, handler);
//   }
// }

class MyDioSocketException extends SocketException {
  late String message;

  MyDioSocketException(
    message, {
    osError,
    address,
    port,
  }) : super(
          message,
          osError: osError,
          address: address,
          port: port,
        );
}
