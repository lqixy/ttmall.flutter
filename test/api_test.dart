import 'package:flutter_test/flutter_test.dart';
import 'package:ttmall/models/home/api_request/api_recommend.dart';

import 'package:ttmall/repositories/category/category_repository.dart';
import 'package:ttmall/repositories/home/index_banner_repository.dart';
import 'package:ttmall/repositories/place/place_repository.dart';

import 'package:ttmall/repositories/products/product_repository.dart';
import 'package:ttmall/repositories/recommend/recommend_repository.dart';
import 'package:ttmall/repositories/topic/topic_repository.dart';

void main() {
  group('api_response', () {
    test('recommendRepository', () async {
      var result = await RecommendRepository().getV4();
      expect(result, isNotNull);
    });

    test('indexbanner', () async {
      var result = await IndexBannerRepository().getAsync();
      expect(result, isNotNull);
    });

    test('get_category', () async {
      var result = await CategoryRepository().get();
      expect(result, isNotNull);
    });

    test('post_distributioninfo', () async {
      var result = await ProductRepository()
          .getServices('faace3b0-1893-41c4-81dc-501f213509c8');
      expect(result, isNotNull);
    });

    test('subString', () {
      String str =
          'https://m.tongtongmall.com/place.html?page=%E6%AF%8D%E5%A9%B4%E5%88%86%E4%BC%9A%E5%9C%BA';
      var start = str.indexOf('=');
      var result = str.substring(start + 1);
      var title = Uri.decodeComponent(result);
      expect(title, equals('母婴分会场'));
      expect(result, equals('%E6%AF%8D%E5%A9%B4%E5%88%86%E4%BC%9A%E5%9C%BA'));
    });

    test('recommend_v2', () async {
      var input = ApiRecommendRequest(placename: '母婴分会场.分类推荐');
      var result = await RecommendRepository().getV2(request: input);
      expect(result, isNotNull);
    });

    test('topic', () async {
      var result = await TopicRepository().get('symm');
      expect(result, isNotNull);
      expect(result.topictag, isNotEmpty);
    });
  });
}
