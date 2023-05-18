import 'package:ttmall/bloc/place/place_bloc.dart';
import 'package:ttmall/bloc/topic/topic_bloc.dart';
import 'package:ttmall/shared/custom_no_data_widget.dart';
import 'package:ttmall/shared/dependencies.dart';
import 'package:ttmall/bloc/home/home_bloc.dart';
import 'package:ttmall/shared/custom_cached_network_image_widget.dart';
import 'package:ttmall/shared/custom_loading_circle_widget.dart';
import 'package:ttmall/utils/app_config.dart';
import 'package:ttmall/utils/app_extensions.dart';

class HomeMenuWidget extends StatelessWidget {
  const HomeMenuWidget({
    super.key,
  });

  void goToPlace(BuildContext context, String name) {
    BlocProvider.of<HomeBloc>(context).add(HomeNavToPlaceEvent(context, name));
  }

  @override
  Widget build(BuildContext context) {
    // final _bloc = context.read<HomeBloc>();
    // _bloc.add(HomeMenuLoadEvent());
    return Container(
      margin: EdgeInsets.only(top: 8.h),
      height: MediaQuery.of(context).size.height * 0.12,
      // decoration: BoxDecoration(color: Colors.white),
      color: AppConfig.primaryWhite,
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoadedState) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: state.model.menulist!.map((e) {
                var start = e.link!.link!.indexOf('=');
                var subStr = e.link!.link!.substring(start + 1);
                var title = Uri.decodeComponent(subStr);
                return HomeMenuItemWidget(e.icon!, e.menu!, () {
                  if (title.isAllEnglish()) {
                    BlocProvider.of<PlaceBloc>(context)
                        .add(PlaceJumpToEvent(context, title));
                  } else {
                    goToPlace(context, title);
                  }
                });
              }).toList(),
            );
          } else {
            return const CustomLoadingCircleWidget();
          }
        },
      ),
    );
  }
}

class HomeMenuItemWidget extends StatelessWidget {
  const HomeMenuItemWidget(
    this.image,
    this.title,
    this.onTap, {
    super.key,
  });
  final String image;
  final String title;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomCachedNetworkImageWidget(
              height: 46.h, width: 46.w, imageUrl: image),
          Text(title),
        ],
      ),
    );
  }
}
