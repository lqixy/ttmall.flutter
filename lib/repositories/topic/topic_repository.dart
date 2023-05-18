import 'package:ttmall/models/topic/api/api_topic_info_request.dart';
import 'package:ttmall/models/topic/topic_model.dart';
import 'package:ttmall/utils/http_util.dart';

class TopicRepository {
  Future<TopicModel> get(String topicCode) async {
    var endpoint = '/public/topic-info-2';
    var request = ApiTopicInfoRequest(topiccode: topicCode);
    var response = await HttpUtil().getAsync(endpoint, input: request);
    return TopicModel.fromJson(response.data);
  }
}
