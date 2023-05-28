import 'package:flutter_test/flutter_test.dart';
import 'package:ttmall/models/home/api_request/api_recommend.dart';
import 'package:ttmall/repositories/recommend/recommend_repository.dart';
import 'package:ttmall/utils/app_extensions.dart';

void main() {
  test('max', () {
    var result = 10 ~/ 3;
    expect(result, 3);

    var ceil = (10 / 3).ceil();
    expect(ceil, 4);
  });

  test('future', () async {
    const titles = [
      '轮播图',
      '分类推荐',
      '尖货秒杀',
      '活动专区',
      '精选品牌',
      '大图推荐1',
      '大图推荐1_商品列表',
      '大图推荐2',
      '大图推荐2_商品列表',
      '大图推荐3',
      '大图推荐3_商品列表',
      '大图推荐4',
      '大图推荐4_商品列表',
      '热门推荐'
    ];
    var stopwatch = Stopwatch()..start();
    var repository = RecommendRepository();
    var futures = titles.map((title) => repository.getV2(
        request: ApiRecommendRequest(placename: '母婴分会场.$title')));
    final responses = await Future.wait(futures);
    stopwatch.stop();
    expect(stopwatch.elapsedMilliseconds, lessThan(800));
  });

  // test('getHours', () {
  //   // var time = '20230526155103'.convertToDateTime();
  //   // var endTime = DateTime.now();

  //   // var hours = time!.difference(endTime).inHours;
  //   // expect(hours, 23);

  //   // double dividend = 10;
  //   // double divisor = 3;
  //   // double quotient = (dividend / divisor).truncateToDouble();
  //   // double remainder = dividend % divisor;
  //   // double result = quotient + (remainder / divisor);
  //   var payexpire = 82037;

  //   var hours = payexpire / 3600;
  //   var value = hours.toStringAsFixed(2);
  //   expect(hours, 22);
  // });
}
