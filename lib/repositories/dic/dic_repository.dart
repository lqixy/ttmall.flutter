import 'package:ttmall/models/dic/api_dic_response.dart';
import 'package:ttmall/utils/app_friendly_exception.dart';
import 'package:ttmall/utils/http_util.dart';

import '../../models/dic/api_dic_request.dart';

class DicRepository {
  Future<List<ApiDicResponse>> get(String type) async {
    var endpoint = '/public/dic';
    var response =
        await HttpUtil().getAsync(endpoint, input: ApiDicRequest(type: type));
    if (response.success) {
      List<dynamic> jsonMap = response.data;

      return jsonMap.map((e) => ApiDicResponse.fromJson(e)).toList();
    } else {
      throw AppFriendlyException(response.msg!);
    }
  }
}
