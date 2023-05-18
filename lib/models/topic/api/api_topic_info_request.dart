import '../../api/request/api_request.dart';

class ApiTopicInfoRequest extends ApiRequest {
  String? topiccode;

  ApiTopicInfoRequest({this.topiccode});

  ApiTopicInfoRequest.fromJson(Map<String, dynamic> json) {
    topiccode = json['topiccode'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['topiccode'] = this.topiccode;
    return data;
  }
}
