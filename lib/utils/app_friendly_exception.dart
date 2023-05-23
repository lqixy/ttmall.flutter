import 'package:dio/dio.dart';

class AppFriendlyException implements Exception {
  final String message;

  const AppFriendlyException(this.message);

  factory AppFriendlyException.create(DioError error) {
    switch (error.type) {
      case DioErrorType.connectionTimeout:
        return BadRequestException('连接超时');
      case DioErrorType.sendTimeout:
        return BadRequestException("请求超时");
      case DioErrorType.receiveTimeout:
        return BadRequestException("响应超时");
      case DioErrorType.badCertificate:
        return BadRequestException("SSL证书无效");
      case DioErrorType.badResponse:
        return BadRequestException("请求错误");

      case DioErrorType.cancel:
        return BadRequestException("请求取消");
      case DioErrorType.connectionError:
        return BadRequestException("连接错误");
      case DioErrorType.unknown:
        return BadRequestException("未知错误");
    }
  }

  // CustomDioSocketException(
  //   this.message, {
  //   osError,
  //   address,
  //   port,
  // }) : super(message, osError: osError, address: address, port: port);
}

class BadRequestException extends AppFriendlyException {
  BadRequestException(String message) : super(message);
}
