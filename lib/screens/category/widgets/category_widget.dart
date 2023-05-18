import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ttmall/screens/category/category.dart';

import '../../../bloc/category/category_bloc.dart';
import '../../../models/category/product_category_model.dart';
import '../../../shared/custom_cached_network_image_widget.dart';
import '../../../shared/custom_loading_circle_widget.dart';
import '../../../utils/app_config.dart';
import 'hot_recommend_tabbar_widget.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  late int selectedIndex = -1;

  void _changeTitleIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
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
          if (state is CategoryLoadingEvent) {
            return const CustomLoadingCircleWidget();
          } else if (state is CategoryLoadedState) {
            // var tabs = _getTitles(state.model.list!);
            return Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        HotRecommendTabbarWidget(() {
                          _changeTitleIndex(-1);
                        }, selectedIndex),
                        ProductCategoryTabbarWidget(
                          selectedIndex: selectedIndex,
                          list: state.model.list,
                        )
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
                      ProductCategoryTabViewWidget(
                          state.model.list!, selectedIndex),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text('no data'),
            );
          }
        },
      ),
    );
  }
}

class ProductCategoryTabbarWidget extends StatefulWidget {
  ProductCategoryTabbarWidget(
      {super.key, required this.selectedIndex, required this.list});
  int? selectedIndex;
  List<CategoryModel>? list;

  @override
  State<ProductCategoryTabbarWidget> createState() =>
      _ProductCategoryTabbarWidgetState();
}

class _ProductCategoryTabbarWidgetState
    extends State<ProductCategoryTabbarWidget> {
  void _changeTitleIndex(int index) {
    setState(() {
      widget.selectedIndex = index;
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
            padding: EdgeInsets.all(14.sp),
            child: SizedBox(
              height: 40.h,
              width: 40.w,
              child: Text(
                value.title!,
                style: TextStyle(
                    color: widget.selectedIndex == key
                        ? AppConfig.primaryBackgroundColorRed
                        : AppConfig.primaryTextColorBlack),
              ),
            ),
          ),
        ));
      },
    );
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: _getTitles(widget.list!));
  }
}

class ProductCategoryTabViewWidget extends StatelessWidget {
  const ProductCategoryTabViewWidget(
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
                                            padding: EdgeInsets.only(top: 10.h),
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

// class ProductCategoryTabbarWidget extends StatelessWidget {
//   const ProductCategoryTabbarWidget(
//     this.onTap,
//     this.selectedIndex,
//     this.list,
//     {
//     super.key,

//   });
//   final Function() onTap;
//   late final int selectedIndex;
//   final List<CategoryModel> list;

//   List<Widget> _getTitles(List<CategoryModel> list) {
//     List<Widget> tabs = [];
//     list.asMap().forEach(
//       (key, value) {
//         tabs.add(GestureDetector(
//           onTap: onTap,
//           child: Container(
//             padding: EdgeInsets.all(14.sp),
//             child: SizedBox(
//               height: 40.h,
//               width: 40.w,
//               child: Text(
//                 value.title!,
//                 style: TextStyle(
//                     color: selectedIndex == key
//                         ? AppConfig.primaryBackgroundColorRed
//                         : AppConfig.primaryTextColorBlack),
//               ),
//             ),
//           ),
//         ));
//       },
//     );
//     return tabs;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(children: _getTitles(list));
//   }
// }
