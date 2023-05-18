import 'package:carousel_slider/carousel_slider.dart';
import 'package:ttmall/shared/custom_loading_circle_widget.dart';

import 'package:ttmall/shared/dependencies.dart';

import 'package:ttmall/shared/custom_cached_network_image_widget.dart';

import '../../../bloc/home/home_bloc.dart';

class HomeNoticesWidget extends StatelessWidget {
  const HomeNoticesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.white,
      decoration: const BoxDecoration(color: Colors.white),
      height: 30.h,
      // width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 10.w,
          ),
          CustomCachedNetworkImageWidget(
            imageUrl: 'https://timgs-v1.tongtongmall.com/697222',
            height: 15.h,
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            // flex: 2,
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeLoadedState) {
                  return CarouselSlider(
                      items: state.model.noticelist!
                          .map((e) => Text(e.title!))
                          .toList(),
                      options: CarouselOptions(
                          // height: 15.h,
                          scrollDirection: Axis.vertical,
                          autoPlay: true,
                          viewportFraction: 1.0));
                } else {
                  return const CustomLoadingCircleWidget();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
