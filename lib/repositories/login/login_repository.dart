import 'package:ttmall/models/login/api/request/api_login_request.dart';
import 'package:ttmall/utils/app_friendly_exception.dart';
import 'package:ttmall/utils/http_util.dart';

import '../../models/login/api/response/api_login_response.dart';

class LoginRepository {
  Future<ApiLoginResponse> login(ApiLoginRequest request) async {
    const String endpoint = '/user/login';

    var response = await HttpUtil().postAsync(endpoint, request);
    if (response.success) {
      return ApiLoginResponse.fromJson(response.data);
    } else {
      throw AppFriendlyException(response.msg!);
    }
  }
}
