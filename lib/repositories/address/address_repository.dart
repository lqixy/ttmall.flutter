import 'package:ttmall/models/address/api/api_address_response.dart';
import 'package:ttmall/models/address/api/api_set_default_request.dart';
import 'package:ttmall/utils/app_friendly_exception.dart';
import 'package:ttmall/utils/http_util.dart';

class AddressRepository {
  Future<ApiAddressResponse> get() async {
    var endpoint = '/user/my-receipt-ads';
    var response = await HttpUtil().getAsync(endpoint);
    if (response.success) {
      return ApiAddressResponse.fromJson(response.data);
    } else {
      throw AppFriendlyException(response.msg!);
    }
  }

  Future<void> setDefault(String addressId) async {
    var endpoint = '/user/receipt-ads-default';
    var input = ApiSetDefaultRequest(addrid: addressId);
    var response = await HttpUtil().postAsync(endpoint, input);
    if (!response.success) {
      throw AppFriendlyException(response.msg!);
    }
  }
}
