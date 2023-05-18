import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:ttmall/shared/dependencies.dart';

import '../../../bloc/category/brand_bloc.dart';
import '../../../models/category/product_brand_model.dart';
import '../../../shared/custom_cached_network_image_widget.dart';
import '../../../shared/custom_loading_circle_widget.dart';
import '../../../utils/app_config.dart';

class BrandViewWidget extends StatefulWidget {
  const BrandViewWidget({super.key});

  @override
  State<BrandViewWidget> createState() => _BrandViewWidgetState();
}

class _BrandViewWidgetState extends State<BrandViewWidget> {
  late int selectedIndex = 0;
  final ItemScrollController _itemScrollController = ItemScrollController();

  @override
  void initState() {
    super.initState();
    context.read<BrandBloc>().add(BrandLoadEvent());
  }

  void _changeTitleIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  List<Widget> _getTitles(List<ProductBrandItemModel> list) {
    List<Widget> items = [];
    list.asMap().forEach((key, value) {
      items.add(GestureDetector(
        onTap: () {
          _changeTitleIndex(key);

          _itemScrollController.scrollTo(
            index: key,
            duration: Duration(milliseconds: 10),
          );
        },
        child: Padding(
            padding: EdgeInsets.all(8.sp),
            child: Text(value.title!,
                style: AppTextStyle.appTextStyle(
                    color: selectedIndex == key
                        ? AppConfig.primaryBackgroundColorRed
                        : AppConfig.secondTextColorGery,
                    size: 16.sp))),
      ));
    });

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrandBloc, BrandState>(
      builder: (context, state) {
        if (state is BrandLoadingState) {
          return const CustomLoadingCircleWidget();
        } else if (state is BrandLoadedState) {
          return Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  // height: MediaQuery.of(context).size.height * 0.1,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: AppConfig.primaryBackgroundColorGrey,
                  ))),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: _getTitles(state.model.list!)),
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: ScrollablePositionedList.builder(
                  itemScrollController: _itemScrollController,
                  itemCount: state.model.list!.length,
                  itemBuilder: (context, index) {
                    var curModel = state.model.list![index];
                    return Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 12.sp),
                          alignment: Alignment.centerLeft,
                          height: 40.h,
                          width: MediaQuery.of(context).size.width,
                          color: AppConfig.primaryBackgroundColorGrey,
                          child: Text(
                            curModel.title!,
                            style: AppTextStyle.appTextStyle(
                                size: 14.sp, fw: FontWeight.bold),
                          ),
                        ),
                        GridView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: curModel.data!.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                            ),
                            itemBuilder: (context, index) {
                              var curData = curModel.data![index];
                              return Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                            color: AppConfig
                                                .primaryBackgroundColorGrey,
                                            width: 0.5),
                                        right: BorderSide(
                                            color: AppConfig
                                                .primaryBackgroundColorGrey,
                                            width: 0.5))),
                                child: CustomCachedNetworkImageWidget(
                                    imageUrl: curData.iconurl!),
                              );
                            })
                      ],
                    );
                    // return Text('data $index');
                  },
                ),
              ),
            ],
          );
        } else if (state is BrandErrorState) {
          return Center(
            child: Text(state.msg),
          );
        } else {
          return const Center(
            child: Text('no data'),
          );
        }
      },
    );
  }
}
