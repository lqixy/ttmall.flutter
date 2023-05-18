// import 'package:dio/dio.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:get_it/get_it.dart';
// import 'package:ttmall/models/home/api_request/api_recommend.dart';
// import 'package:ttmall/models/home/api_request/apii_indexbanner_request.dart';

// import 'package:ttmall/repositories/cart/cart_repository.dart';
// import 'package:ttmall/repositories/category/brand_repository.dart';
// import 'package:ttmall/repositories/category/category_repository.dart';
// import 'package:ttmall/repositories/comments/comments_repository.dart';
// import 'package:ttmall/repositories/home/index_banner_repository.dart';
// import 'package:ttmall/repositories/home/recommend_repository.dart';
// import 'package:ttmall/repositories/orders/order_confirm_repository.dart';
// import 'package:ttmall/repositories/pickup/pick_repository.dart';
// import 'package:ttmall/repositories/products/product_repository.dart';

// import 'package:ttmall/utils/app_extensions.dart';
// import 'package:ttmall/utils/http_util.dart';
// import 'package:ttmall/utils/request_config.dart';

// void main() async {
//   TestWidgetsFlutterBinding.ensureInitialized();

//   GetIt.instance.registerLazySingleton<CategoryRepository>(
//     () => CategoryRepository(),
//   );
//   group('index_banner', () {
//     test('getAsync', () async {
//       var result = await IndexBannerRepository().getAsync();
//       expect(result, isNotNull);
//       expect(result.menulist, isNotEmpty);
//     });
//   });

//   group('recommend', () {
//     test('异步获取首页推荐', () async {
//       // var result = await RecommendRepository().getAsync();
//       var endpoint = '/public/recommend-ver4';
//       var input = ApiRecommendRequest();
//       var uri = Uri.parse(endpoint).replace(queryParameters: input.toJson());
//       var url = uri.toString();
//       var response2 = await Dio(BaseOptions(
//           baseUrl: RequestConfig.baseUrl,
//           headers: {'Authorization': RequestConfig.ttmallToken})).get(url);
//       var response = await HttpUtil().getAsync(
//         endpoint,
//       );
//       var result = await RecommendRepository().getRecommend();

//       // var result2 =
//       //     await RecommendRepository().getRecommendV2(ApiRecommendRequest());
//       // var result2 = await HttpUtil().get(
//       //     '/public/recommend-ver4?placename=%E9%A6%96%E9%A1%B5-%E5%A4%9A%E5%9B%BE%E6%A5%BC%E5%B1%82');
//       expect(result, isNotNull);
//     });

//     test('get json', () async {
//       var json = await rootBundle.loadString('assets/datas/recommend.json');
//       expect(json, isNotNull);
//     });
//   });

//   group('product', () {
//     test('getAsync', () async {
//       var result = await ProductRepository().getAsync();
//       expect(result, isNotNull);
//     });

//     test('getServices', () async {
//       var result = await ProductRepository().getServices();
//       expect(result, isNotNull);
//       expect(result.service, isNotEmpty);
//     });

//     test('getGoods', () async {
//       var result = await ProductRepository().getGoods();
//       expect(result, isNotNull);
//     });

//     test('getProdetailImages', () async {
//       var result = await ProductRepository().getProdetailImages();
//       expect(result, isNotEmpty);
//     });

//     test('stringToDateTime', () {
//       var str = '20180331222044';
//       var time = str.stringToDateTime();
//       // var time = DateFormat('yyyyMMddHHmmss').parse(str);
//       expect(time, isNotNull);
//     });
//   });

//   group('comments', () {
//     test('getComments', () async {
//       var result = await CommentsRepository().getComment();
//       expect(result.list, isNotNull);
//     });
//   });

//   group('category', () {
//     test('get_product_category', () async {
//       var result = await CategoryRepository().get();
//       expect(result, isNotNull);
//       expect(result.list?.length, 8);
//     });

//     test('get_hot_recommends', () async {
//       var result = await CategoryRepository().getHotRecommends();
//       expect(result, isNotNull);
//       expect(result.list!.length, 6);
//     });
//   });

//   group('brand', () {
//     test('get', () async {
//       var result = await BrandRepository().get();
//       expect(result, isNotNull);
//       expect(result.list, isNotNull);
//     });
//   });

//   group('cart', () {
//     test('get', () async {
//       var result = await CartRepository().get();
//       expect(result, isNotNull);
//       expect(result.list?.first.shopsName, isNotNull);
//       // expect(result.list!.length, 2);
//     });
//   });

//   group('pickup', () {
//     test('getPickAddress', () async {
//       var result = await PickRepository().get();
//       expect(result, isNotNull);
//     });
//   });

//   group('order', () {
//     test('order_confirm', () async {
//       var result = await OrderConfirmRepository().get();
//       expect(result, isNotNull);
//     });
//   });
// }
