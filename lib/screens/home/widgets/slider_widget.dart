import 'package:ttmall/shared/dependencies.dart';
import 'package:ttmall/shared/custom_cached_network_image_widget.dart';
import 'package:ttmall/shared/custom_loading_circle_widget.dart';

import '../../../bloc/home/home_bloc.dart';
import '../../../shared/custom_slider_widget.dart';

class HomeSliderWidget extends StatelessWidget {
  const HomeSliderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoadedState) {
            // Future.delayed(Duration(seconds: 1));
            return CustomSliderWidget(
              state.model.adlist!
                  .map((e) =>
                      CustomCachedNetworkImageWidget(imageUrl: e.picurl!))
                  .toList(),
              height: 200.h,
              width: MediaQuery.of(context).size.width,
            );
          } else {
            return const CustomLoadingCircleWidget();
          }
        },
      ),
    );
  }
}
