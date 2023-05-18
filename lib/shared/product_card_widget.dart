import 'package:ttmall/bloc/cart/cart_bloc.dart';
import 'package:ttmall/bloc/home/home_bloc.dart';
import 'package:ttmall/bloc/products/product_bloc.dart';
import 'package:ttmall/shared/custom_cached_network_image_widget.dart';
import 'package:ttmall/shared/dependencies.dart';
import 'package:ttmall/utils/app_config.dart';

import '../models/recommend/recommend_model.dart';

class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget(this.model,
      {super.key,
      this.height,
      this.width,
      this.nameColor,
      this.nameSize = 14,
      this.nameFw = FontWeight.bold,
      this.priceColor = AppConfig.primaryBackgroundColorRed,
      this.priceSize,
      this.priceFw,
      this.isVisible = false,
      this.margin =
          const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      this.padding});
  final double? height;
  final double? width;

  final Color? nameColor;
  final double? nameSize;
  final FontWeight? nameFw;

  final Color? priceColor;
  final double? priceSize;
  final FontWeight? priceFw;

  final bool isVisible;
  final RecommendItemModel model;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<ProductBloc>(context)
            .add(ProductJumpToDetailEvent(context, model.goodsid!));
      },
      child: Container(
        margin: margin,
        color: AppConfig.primaryWhite,
        height: height,
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 9,
              child: CustomCachedNetworkImageWidget(
                imageUrl: model.pic!,
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  model.title!,
                  softWrap: false,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.appTextStyle(
                    color: nameColor,
                    size: nameSize,
                    fw: nameFw,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      model.sellprice == null || model.sellprice!.isEmpty
                          ? ''
                          : '¥${model.sellprice}',
                      style: AppTextStyle.appTextStyle(
                        color: priceColor,
                        size: priceSize,
                        fw: priceFw,
                      ),
                    ),
                    Visibility(
                        visible: isVisible,
                        child: GestureDetector(
                          onTap: () {
                            BlocProvider.of<CartBloc>(context)
                                .add(CartInsertEvent(model.goodsid!));
                          },
                          child: const Image(
                            image: AssetImage('assets/images/add_cart.png'),
                            height: 20,
                            width: 20,
                          ),
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
