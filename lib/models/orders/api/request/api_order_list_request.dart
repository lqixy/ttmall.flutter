import '../../../api/request/api_request.dart';

class ApiOrderListRequest extends ApiRequest {
  String? orderstatus;
  String? pagesize;
  String? curpage;

  ApiOrderListRequest(
      {this.orderstatus = '1', this.pagesize = '10', this.curpage = '1'});

  ApiOrderListRequest.fromJson(Map<String, dynamic> json) {
    orderstatus = json['orderstatus'];
    pagesize = json['pagesize'];
    curpage = json['curpage'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderstatus'] = this.orderstatus;
    data['pagesize'] = this.pagesize;
    data['curpage'] = this.curpage;
    return data;
  }
}
