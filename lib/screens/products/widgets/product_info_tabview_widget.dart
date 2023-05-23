import 'package:ttmall/screens/products/widgets/product_brand_widget.dart';
import 'package:ttmall/screens/products/widgets/product_des_widget.dart';
import 'package:ttmall/screens/products/widgets/product_price_widget.dart';
import 'package:ttmall/screens/products/widgets/product_receipt_service_widget.dart';
import 'package:ttmall/screens/products/widgets/product_recommend_goods_widget.dart';
import 'package:ttmall/screens/products/widgets/product_title_widget.dart';
import 'package:ttmall/shared/dependencies.dart';

import '../../../bloc/products/product_bloc.dart';
import '../../../shared/custom_cached_network_image_widget.dart';
import '../../../shared/custom_sizedbox_widget.dart';
import '../../../shared/custom_slider_widget.dart';

class ProductInfoTabViewWidget extends StatelessWidget {
  const ProductInfoTabViewWidget(this.state, {super.key});

  final ProductLoadedState state;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomSliderWidget(
            state.model.goodsurl!
                .map((e) => CustomCachedNetworkImageWidget(
                    width: MediaQuery.of(context).size.width, imageUrl: e.url!))
                .toList(),
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width,
          ),
          ProductPriceWidget(
            state.model.goodsstandard!.first,
          ),
          ProductTitleWidget(
            model: state.model.goodsstandard?.first,
          ),
          ProductDesWidget(
            goodsdesc: state.model.goodsdesc,
          ),
          const Custom10SizedboxWidget(),
          ProductReceiptServiceWidget(
            models: state.serviceModel.service ?? List.empty(),
            onTap: () {
              print('click receiptService');
            },
          ),
          const Custom10SizedboxWidget(),
          ProductBrandWidget(
            model: state.model.goodsbrand!,
          ),
          const Custom10SizedboxWidget(),
          const ProductRecommendGoodsTitleWidget(),
          ProductRecommendGoodsBodyWidget(
            state.goods.list!,
          ),
          SizedBox(
            height: 30.h,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.07,
          ),
        ],
      ),
    );
  }
}
