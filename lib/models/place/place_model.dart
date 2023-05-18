import 'package:ttmall/models/recommend/recommend_model.dart';

class PlaceModel {
  final RecommendModel slider;
  final RecommendModel category;
  final RecommendModel miaosha;
  final RecommendModel activity;
  final RecommendModel brand;

  // final List<PlaceLargeRecommendModel> largeRecommend;
  final RecommendModel bigimage;
  final RecommendModel product;
  final RecommendModel bigimage2;
  final RecommendModel product2;
  final RecommendModel bigimage3;
  final RecommendModel product3;
  final RecommendModel bigimage4;
  final RecommendModel product4;
  final RecommendModel hotrecommend;

  const PlaceModel(
      this.slider,
      this.category,
      this.miaosha,
      this.activity,
      this.brand,
      // this.largeRecommend,
      this.bigimage,
      this.product,
      this.bigimage2,
      this.product2,
      this.bigimage3,
      this.product3,
      this.bigimage4,
      this.product4,
      this.hotrecommend);
}

class PlaceLargeRecommendModel {
  final RecommendModel largeImage;
  final RecommendModel product;

  const PlaceLargeRecommendModel(this.largeImage, this.product);
}
