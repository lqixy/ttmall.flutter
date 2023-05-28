import 'package:ttmall/models/orders/api/request/api_order_compute_request.dart';
import 'package:ttmall/models/orders/api/request/api_order_detail_request.dart';
import 'package:ttmall/models/orders/api/request/api_order_list_request.dart';

import '../../models/orders/api/request/api_order_check_request.dart';
import '../../models/orders/api/request/api_order_submit_request.dart';
import '../../models/orders/api/response/api_order_compute_response.dart';
import '../../models/orders/api/response/api_order_detail_response.dart';
import '../../models/orders/api/response/api_order_list_response.dart';
import '../../models/orders/api/response/api_order_submit_response.dart';
import '../../models/orders/order_confirm_model.dart';
import '../../utils/app_friendly_exception.dart';
import '../../utils/http_util.dart';

class OrderRepository {
  /// 确认订单
  Future<OrderConfirmModel> confirm() async {
    // var jsonStr = await rootBundle.loadString('assets/datas/orderConfirm.json');
    // return OrderConfirmModel.fromJson(json.decode(jsonStr));

    var endpoint = '/user/order-check-ver2';
    var input = ApiOrderCheckRequest();
    var response = await HttpUtil().postAsync(endpoint, input);
    if (response.success) {
      return OrderConfirmModel.fromJson(response.data);
    } else {
      throw AppFriendlyException(response.msg!);
    }
  }

  /// 提交订单
  Future<ApiOrderSubmitResponse> submit(ApiOrderSubmitRequest request) async {
    var endpoint = '/user/order-submit-ver2';
    // var input = ApiOrderSubmitRequest();
    var response = await HttpUtil().postAsync(endpoint, request);
    if (response.success) {
      return ApiOrderSubmitResponse.fromJson(response.data);
    } else {
      throw AppFriendlyException(response.msg!);
    }
  }

  /// 结算订单
  Future<ApiOrderComputeResponse> compute(
      ApiOrderComputeRequest request) async {
    var endpoint = '/user/order-compute-ver2';
    var response = await HttpUtil().postAsync(endpoint, request);
    if (response.success) {
      return ApiOrderComputeResponse.fromJson(response.data);
    } else {
      throw AppFriendlyException(response.msg!);
    }
  }

  Future<ApiOrderListResponse> list(ApiOrderListRequest request) async {
    var endpoint = '/order/myorderlist-ver2';
    var response = await HttpUtil().getAsync(endpoint, input: request);
    if (response.success) {
      return ApiOrderListResponse.fromJson(response.data);
    } else {
      throw AppFriendlyException(response.msg!);
    }
  }

  Future<ApiOrderDetailResponse> detail(ApiOrderDetailRequest request) async {
    var endpoint = '/order/orderdetail-ver2';
    var response = await HttpUtil().getAsync(endpoint, input: request);
    if (response.success) {
      return ApiOrderDetailResponse.fromJson(response.data);
    } else {
      throw AppFriendlyException(response.msg!);
    }
  }
}
