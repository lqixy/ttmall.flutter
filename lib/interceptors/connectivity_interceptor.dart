// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:dio/dio.dart';

// import '../utils/app_friendly_exception.dart';

// class ConnectivityInterceptor extends Interceptor {
//   @override
//   void onRequest(
//       RequestOptions options, RequestInterceptorHandler handler) async {
//     var connectivityResult = await Connectivity().checkConnectivity();
//     if (connectivityResult == ConnectivityResult.none) {
//       throw AppFriendlyException('当前网络不可用,请检查您的网络.');
//       // throw DioError(
//       //   // type: DioErrorType.connectionError,
//       //   requestOptions: options,
//       //   message: '当前网络不可用,请检查您的网络.',
//       //   // error: const AppFriendlyException('当前网络不可用,请检查您的网络.')
//       // );
//     }

//     super.onRequest(options, handler);
//   }
// }
