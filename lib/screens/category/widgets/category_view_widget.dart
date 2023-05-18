import 'package:ttmall/shared/dependencies.dart';

import '../../../bloc/category/category_bloc.dart';
import '../../../models/category/hot_recommend_model.dart';
import '../../../models/category/product_category_model.dart';
import '../../../shared/custom_cached_network_image_widget.dart';
import '../../../shared/custom_loading_circle_widget.dart';
import '../../../utils/app_config.dart';

class CategoryViewWidget extends StatefulWidget {
  const CategoryViewWidget({super.key});

  @override
  State<CategoryViewWidget> createState() => _CategoryViewWidgetState();
}

class _CategoryViewWidgetState extends State<CategoryViewWidget> {
  late int selectedIndex = -1;

  void _changeTitleIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  List<Widget> _getTitles(List<CategoryModel> list) {
    List<Widget> tabs = [];
    list.asMap().forEach(
      (key, value) {
        tabs.add(GestureDetector(
          onTap: () {
            _changeTitleIndex(key);
          },
          child: Container(
            margin: EdgeInsets.all(8.sp),
            child: SizedBox(
              height: 56.h,
              width: 46.w,
              child: Text(
                value.title!,
                style: AppTextStyle.appTextStyle(
                    color: selectedIndex == key
                        ? AppConfig.primaryBackgroundColorRed
                        : AppConfig.primaryTextColorBlack,
                    size: 16.sp),
              ),
            ),
          ),
        ));
      },
    );
    return tabs;
  }

  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(CategoryLoadingEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoadedState) {
            var tabs = _getTitles(state.model.list!);
            return Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        HotRecommendTabbarWidget(() {
                          _changeTitleIndex(-1);
                        }, selectedIndex),
                        Column(children: tabs)
                      ],
                    ),
                  ),
                ),
                Positioned(
                    left: 80.w,
                    child: Container(
                      width: 1,
                      height: MediaQuery.of(context).size.height,
                      color: AppConfig.primaryBackgroundColorGrey,
                    )),
                Positioned(
                  right: 10.w,
                  child: Column(
                    children: [
                      HotRecommendTabViewWidget(
                          selectedIndex, state.hotRecommendModel.list!),
                      CategoryTabViewWidget(state.model.list!, selectedIndex),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const CustomLoadingCircleWidget();
          }
        },
      ),
    );
  }
}

class HotRecommendTabViewWidget extends StatelessWidget {
  const HotRecommendTabViewWidget(
    this.selectedIndex,
    this.list, {
    super.key,
  });

  final int selectedIndex;
  final List<HotRecommendItemModel> list;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: selectedIndex == -1,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width * 0.7,
        child: GridView.builder(
          itemCount: list.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemBuilder: (context, index) {
            var curHot = list[index];
            return Container(
              padding: EdgeInsets.all(6.sp),
              child: Column(
                children: [
                  CustomCachedNetworkImageWidget(imageUrl: curHot.iconurl!),
                  Container(
                    padding: EdgeInsets.only(top: 8.sp),
                    child: Text(
                      curHot.title!,
                      style: AppTextStyle.appTextStyle(
                          color: AppConfig.secondTextColorGery, size: 12.sp),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class HotRecommendTabbarWidget extends StatelessWidget {
  const HotRecommendTabbarWidget(this.onTap, this.selectedIndex, {super.key});

  final Function() onTap;
  final int selectedIndex;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // color: Colors.orange,
        margin: EdgeInsets.all(8.sp),
        child: SizedBox(
          height: 56.h,
          width: 46.w,
          child: Text(
            '热门推荐',
            style: AppTextStyle.appTextStyle(
                size: 16.sp,
                color: selectedIndex == -1
                    ? AppConfig.primaryBackgroundColorRed
                    : AppConfig.primaryTextColorBlack),
          ),
        ),
      ),
    );
  }
}

class CategoryTabViewWidget extends StatelessWidget {
  const CategoryTabViewWidget(
    this.list,
    this.selectedIndex, {
    super.key,
  });
  final List<CategoryModel> list;
  final int selectedIndex;
  @override
  Widget build(BuildContext context) {
    List<Widget> _items = [];
    list.asMap().forEach(
      (key, value) {
        _items.add(Visibility(
          visible: selectedIndex == key,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width * 0.7,
            child: SingleChildScrollView(
              child: Column(
                children: value.data!
                    .map((e) => Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 6.sp),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    e.title!,
                                    style: AppTextStyle.appTextStyle(
                                        size: 12.sp, fw: FontWeight.bold),
                                  ),
                                  Text(
                                    '更多',
                                    style: TextStyle(
                                        color: AppConfig.secondColorGrey),
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: e.data!.isNotEmpty,
                              child: GridView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: e.data!.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 4.sp,
                                          mainAxisSpacing: 20.sp),
                                  itemBuilder: (context, index) {
                                    var curModel = e.data![index];
                                    return Column(
                                      // mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: CustomCachedNetworkImageWidget(
                                              imageUrl: curModel.itemurl!),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          // padding: EdgeInsets.only(top: 8.sp),
                                          child: Container(
                                            padding: EdgeInsets.all(4.sp),
                                            child: Text(
                                              curModel.item!,
                                              style: AppTextStyle.appTextStyle(
                                                  color: AppConfig
                                                      .secondTextColorGery,
                                                  size: 12.sp),
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  }),
                            ),
                            Divider(
                              height: 1,
                              color: AppConfig.secondColorGrey,
                            )
                          ],
                        ))
                    .toList(),
              ),
            ),
          ),
        ));
      },
    );
    return Column(children: _items);
  }
}
