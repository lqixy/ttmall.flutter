import 'package:ttmall/models/user/api/response/api_user_center_response.dart';
import 'package:ttmall/models/user/api/response/api_user_info_response.dart';
import 'package:ttmall/utils/app_friendly_exception.dart';
import 'package:ttmall/utils/http_util.dart';

class UserRepository {
  Future<ApiUserInfoResponse> getUserInfo() async {
    var endpoint = '/user/user-info';
    var response = await HttpUtil().getAsync(endpoint);
    if (response.success) {
      return ApiUserInfoResponse.fromJson(response.data);
    } else {
      throw AppFriendlyException(response.msg!);
    }
  }

  Future<ApiUserCenterResponse> getUserCenter() async {
    var endpoint = '/user/user-center';
    var response = await HttpUtil().getAsync(endpoint);
    if (response.success) {
      return ApiUserCenterResponse.fromJson(response.data);
    } else {
      throw AppFriendlyException(response.msg!);
    }
  }
}
