import 'package:ttmall/shared/dependencies.dart';
import '../../../shared/product_card_widget.dart';

class RecommentProductWidget extends StatelessWidget {
  const RecommentProductWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                    height: 20.h,
                    image: NetworkImage(
                        'https://timgs-v1.tongtongmall.com/5c0f85')),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  '精品推荐',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          // Container(
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       ProductCardWidget(
          //         id: '',
          //         image: '',
          //         productName: '',
          //         price: '',
          //         width: MediaQuery.of(context).size.width * 0.49,
          //         height: 220.h,
          //       ),
          //       ProductCardWidget(
          //         id: '',
          //         image: '',
          //         productName: '',
          //         price: '',
          //         width: MediaQuery.of(context).size.width * 0.49,
          //         height: 220.h,
          //       ),
          //     ],
          //   ),
          // ),
          SizedBox(
            height: 4.h,
          ),
          // Container(
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       ProductCardWidget(
          //         id: '',
          //         image: '',
          //         productName: '',
          //         price: '',
          //         width: MediaQuery.of(context).size.width * 0.49,
          //         height: 220.h,
          //       ),
          //       ProductCardWidget(
          //         id: '',
          //         image: '',
          //         productName: '',
          //         price: '',
          //         width: MediaQuery.of(context).size.width * 0.49,
          //         height: 220.h,
          //       ),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
