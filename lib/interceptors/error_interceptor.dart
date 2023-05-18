import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

class CustomDioSocketException extends SocketException {
  late String message;

  CustomDioSocketException(
    this.message, {
    osError,
    address,
    port,
  }) : super(message, osError: osError, address: address, port: port);
}

class ErrorInterceptor extends Interceptor {
  Future<bool> hasInternet() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.type == DioErrorType.connectionError) {
      // err.error
    }
    super.onError(err, handler);
  }
}
