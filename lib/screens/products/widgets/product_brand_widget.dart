import 'package:ttmall/shared/dependencies.dart';

import '../../../models/products/product_info_model.dart';
import '../../../shared/custom_cached_network_image_widget.dart';
import '../../../utils/app_config.dart';

// ignore: must_be_immutable
class ProductBrandWidget extends StatelessWidget {
  ProductBrandWidget({super.key, required this.model});

  Goodsbrand model;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      // height: 24.h,
      child: GestureDetector(
        onTap: () {
          // print('brand');
          // TODO nav to brand_page;
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                model.brandurl!.isNotEmpty
                    ? Container(
                        margin: EdgeInsets.only(right: 10.w),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: AppConfig.primaryBackgroundColorGrey,
                                width: 1)),
                        child: CustomCachedNetworkImageWidget(
                            fit: BoxFit.cover,
                            height: 46.h,
                            width: 46.h,
                            imageUrl: model.brandurl!),
                      )
                    : const SizedBox(
                        width: 0,
                      ),
                Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(model.country!),
                        SizedBox(
                          width: 10.w,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppConfig.primaryBackgroundColorGrey,
                                  width: 1)),
                          child: CustomCachedNetworkImageWidget(
                              fit: BoxFit.cover,
                              height: 12.h,
                              width: 20.w,
                              imageUrl: model.countryimg!),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(model.brandname!),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                const Text('进入'),
                Icon(
                  Icons.chevron_right_outlined,
                  color: AppConfig.secondColorGrey,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
