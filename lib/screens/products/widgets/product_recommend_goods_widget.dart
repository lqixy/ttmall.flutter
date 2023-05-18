import 'package:ttmall/shared/dependencies.dart';

import '../../../models/products/goods_model.dart';
import '../../../shared/custom_cached_network_image_widget.dart';
import '../../../utils/app_config.dart';

class ProductRecommendGoodsBodyWidget extends StatelessWidget {
  const ProductRecommendGoodsBodyWidget(this.goods, {super.key});

  final List<GoodsModel> goods;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: goods
                  .map((e) => ProductRecommendGoodsBodyItemWidget(
                        e,
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}

class ProductRecommendGoodsTitleWidget extends StatelessWidget {
  const ProductRecommendGoodsTitleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.all(14),
        child: Text(
          '推荐商品',
          style: AppTextStyle.appTextStyle(size: 14.sp),
          textAlign: TextAlign.start,
        ));
  }
}

class ProductRecommendGoodsBodyItemWidget extends StatelessWidget {
  const ProductRecommendGoodsBodyItemWidget(
    this.model, {
    super.key,
  });

  final GoodsModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
      decoration: BoxDecoration(
          border: Border.all(
              color: AppConfig.primaryBackgroundColorGrey, width: 1)),
      height: MediaQuery.of(context).size.height * 0.32,
      width: MediaQuery.of(context).size.width * 0.35,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 9,
              child: CustomCachedNetworkImageWidget(
                fit: BoxFit.cover,
                imageUrl: model.goodsurl!,
              )),
          // SizedBox(
          //   width: 15.w,
          // ),
          Expanded(
            flex: 3,
            child: Text(
              model.goodsname!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '¥',
                  style: AppTextStyle.appTextStyle(
                      color: AppConfig.primaryBackgroundColorRed,
                      size: 12.sp,
                      fw: FontWeight.w500),
                ),
                Text(
                  '${model.sellprice?.split('.')[0]}',
                  style: AppTextStyle.appTextStyle(
                      color: AppConfig.primaryBackgroundColorRed,
                      size: 16.sp,
                      fw: FontWeight.w500),
                ),
                Text(
                  '.',
                  style: AppTextStyle.appTextStyle(
                      color: AppConfig.primaryBackgroundColorRed,
                      size: 20.sp,
                      fw: FontWeight.w400),
                ),
                Text(
                  '${model.sellprice?.split('.')[1]}',
                  style: AppTextStyle.appTextStyle(
                      color: AppConfig.primaryBackgroundColorRed,
                      size: 12.sp,
                      fw: FontWeight.w400),
                ),
              ],
            ),
          ),
        ],
      ),
      // color: Colors.amber,
    );
  }
}
