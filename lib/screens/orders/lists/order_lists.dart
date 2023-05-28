import 'package:ttmall/bloc/navigator/navigator_bloc.dart';
import 'package:ttmall/models/orders/api/request/api_order_list_request.dart';
import 'package:ttmall/models/orders/api/response/api_order_list_response.dart';
import 'package:ttmall/screens/orders/detail/order_detail.dart';
import 'package:ttmall/shared/custom_badge_widget.dart';
import 'package:ttmall/shared/custom_button_widget.dart';
import 'package:ttmall/shared/custom_cached_network_image_widget.dart';
import 'package:ttmall/shared/custom_error_widget.dart';
import 'package:ttmall/shared/custom_loading_circle_widget.dart';
import 'package:ttmall/shared/custom_more_popup_button_widget.dart';
import 'package:ttmall/shared/custom_sizedbox_widget.dart';
import 'package:ttmall/shared/dependencies.dart';
import 'package:ttmall/utils/app_config.dart';
import 'package:ttmall/utils/app_extensions.dart';

import '../../../bloc/orders/lists/order_lists_bloc.dart';
import '../../../bloc/orders/order_bloc.dart';
import '../../../bloc/user/user_bloc.dart';
import '../../../models/user/api/response/api_user_center_response.dart';

class OrderListsScreen extends StatefulWidget {
  const OrderListsScreen(this.orderType, {super.key});
  final int orderType;
  @override
  State<OrderListsScreen> createState() => _OrderListsScreenState();
}

class _OrderListsScreenState extends State<OrderListsScreen> {
  late int _selectedIndex = 1;
  // late int _totalCount = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.orderType;
  }

  void _onSelectedIndexChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppConfig.secondBackgroundColorGrey,
        backgroundColor: AppConfig.primaryWhite,
        elevation: 0,
        title: Text(
          '我的订单',
          style: AppTextStyle.appTextStyle(
              color: AppConfig.primaryTextColorBlack, size: 14.sp),
        ),
        centerTitle: true,
        actions: [
          CustomMorePopupButtonWidget(pageIndex: -1),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height * 0.06,
            left: 0,
            child: OrderListOrdersWidget(
              _selectedIndex,
              //  _totalCount
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            height: MediaQuery.of(context).size.height * 0.06,
            child: OrderListTitleWidget(
              _selectedIndex,
              onSelectedIndexChanged: _onSelectedIndexChanged,
              // onTotalCountChanged: _onTotalCountChanged,
            ),
          ),
        ],
      ),
    );
  }
}

class OrderListOrdersWidget extends StatefulWidget {
  final int selectedIndex;
  // final int totalCount;
  const OrderListOrdersWidget(this.selectedIndex, {super.key});

  @override
  State<OrderListOrdersWidget> createState() => _OrderListOrdersWidgetState();
}

class _OrderListOrdersWidgetState extends State<OrderListOrdersWidget> {
  final ScrollController _scrollController = ScrollController();

  late int curPage = 1;

  @override
  void initState() {
    super.initState();

    // context.read<OrderBloc>().add(OrderListLoadEvent(ApiOrderListRequest()));
    context.read<OrderListsBloc>().add(OrderListsLoad(
        ApiOrderListRequest(orderstatus: '${widget.selectedIndex}'),
        reload: true));
    _scrollController.addListener(_onScroll);
  }

  @override
  void didUpdateWidget(covariant OrderListOrdersWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      context.read<OrderListsBloc>().add(OrderListsLoad(
            ApiOrderListRequest(orderstatus: '${widget.selectedIndex}'),
            reload: true,
          ));
    }
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    // orders.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderListsBloc, OrderListsState>(
      builder: (context, state) {
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: state.orders.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 20),
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width,
                          child: Image(
                              image:
                                  AssetImage('assets/images/empty_orders.png')),
                        ),
                        Text(
                          '您还没有想着订单',
                          style: AppTextStyle.appTextStyle(
                              color: AppConfig.secondBackgroundColorGrey,
                              size: 14.sp),
                        )
                      ],
                    ),
                  )
                : Column(
                    children: [
                      Column(
                        children: state.orders
                            .map((e) => OrderListSettlementItemWidget(
                                e, widget.selectedIndex))
                            .toList(),
                      ),
                    ],
                  ),
          ),
        );
        //   case OrderListsStatus.failure:
        //     return CustomErrorWidget('Error');
        // }
      },
    );
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final pixels = _scrollController.position.pixels;
    // final _currentScroll = _scrollController.offset;
    if (pixels == maxScroll) {
      // print('加载更多');
      setState(() {
        curPage += 1;
      });
      context.read<OrderListsBloc>().add(OrderListsLoad(
          ApiOrderListRequest(
              orderstatus: '${widget.selectedIndex}', curpage: '$curPage'),
          reload: false));
    }
  }
}

class OrderListTitleWidget extends StatefulWidget {
  final ValueChanged<int>? onSelectedIndexChanged;
  // final ValueChanged<int>? onTotalCountChanged;
  final int selectedIndex;

  const OrderListTitleWidget(
    this.selectedIndex, {
    super.key,
    this.onSelectedIndexChanged,
  });

  @override
  State<OrderListTitleWidget> createState() => _OrderListTitleWidgetState();
}

class _OrderListTitleWidgetState extends State<OrderListTitleWidget> {
  final List<OrderListTitleModel> titles = [
    OrderListTitleModel('全部', 1),
    OrderListTitleModel('待付款', 2),
    OrderListTitleModel('待发货', 5),
    OrderListTitleModel('待收货', 3),
    OrderListTitleModel('待评价', 4),
  ];

  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(UserCenterLoadEvent());
  }

  late int selecteIndex = widget.selectedIndex;
  void _changeTabTitleIndex(int index) {
    setState(() {
      selecteIndex = index;
    });
    widget.onSelectedIndexChanged?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.06,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppConfig.primaryBackgroundColorGrey,
          ),
        ),
        color: AppConfig.primaryWhite,
      ),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserCenterLoadedState) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _getTabtitles(
                state.userCenter,
              ),
            );
          } else if (state is UserCenterErrorState) {
            return CustomErrorWidget(state.msg);
          } else {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _getTabtitles(null),
            );
          }
        },
      ),
    );
  }

  List<Widget> _getTabtitles(ApiUserCenterResponse? userCenter) {
    List<Widget> items = [];
    for (var element in titles) {
      var count = 0;
      switch (element.title) {
        case '待付款':
          count = userCenter?.unpaidorder ?? 0;
          break;
        case '待发货':
          count = userCenter?.waitsendorder ?? 0;
          break;
        case '待收货':
          count = userCenter?.noreceiveorder ?? 0;
          break;
        case '待评价':
          count = userCenter?.nocommentorder ?? 0;
          break;
      }
      var title = GestureDetector(
          onTap: () {
            _changeTabTitleIndex(element.index);
          },
          child: Stack(children: [
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.2,
              decoration: BoxDecoration(
                border: selecteIndex == element.index
                    ? Border(
                        bottom: BorderSide(
                            color: AppConfig.primaryBackgroundColorRed),
                      )
                    : null,
              ),
              child: Text(
                element.title,
                style: AppTextStyle.appTextStyle(
                    color: selecteIndex == element.index
                        ? AppConfig.primaryTextColorBlack
                        : AppConfig.secondTextColorGery),
              ),
            ),
            Positioned(
                top: 0,
                right: 4,
                child: CustomBadgeWidget(
                  count,
                  height: 12.h,
                  fontSize: 10.sp,
                )),
          ]));
      items.add(title);
    }

    return items;
  }
}

class OrderListSettlementItemWidget extends StatelessWidget {
  const OrderListSettlementItemWidget(
    this.order,
    this.selectedIndex, {
    super.key,
  });
  final int selectedIndex;
  final ApiOrderListItem order;

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(8.0),
      height: MediaQuery.of(context).size.height * 0.26,
      width: MediaQuery.of(context).size.width,
      color: AppConfig.primaryWhite,
      child: Column(
        children: [
          const Custom5SizedboxWidget(),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    order.time.convertToString(),
                    style: AppTextStyle.appTextStyle(
                        color: AppConfig.primaryTextColorBlack,
                        fw: FontWeight.bold,
                        size: 12.sp),
                  ),
                  Text(
                    '订单状态',
                    style: AppTextStyle.appTextStyle(
                        color: AppConfig.primaryBackgroundColorRed,
                        size: 10.sp),
                  )
                ],
              ),
            ),
          ),
          Expanded(
              flex: 3,
              child: GestureDetector(
                  onTap: () {
                    BlocProvider.of<NavigatorBloc>(context).add(
                        NavigatorPushEvent(context,
                            OrderDetailScreen(order.ordersettlementid!)));
                  },
                  child: OrderListSettlementGoodsItemWidget(order.goods!))),
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                  // color: Colors.amber,
                  border: Border(
                      top: BorderSide(
                          color: AppConfig.primaryBackgroundColorGrey))),
              height: MediaQuery.of(context).size.height * 0.1,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '实付款: ',
                    style: AppTextStyle.appTextStyle(
                      size: 12.sp,
                      fw: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      '¥${order.price}',
                      style: AppTextStyle.appTextStyle(
                        size: 12.sp,
                        color: AppConfig.primaryBackgroundColorRed,
                        fw: FontWeight.bold,
                      ),
                    ),
                  ),
                  CustomButtonWidget(
                      height: MediaQuery.of(context).size.height * 0.03,
                      width: MediaQuery.of(context).size.width * 0.2,
                      backgroundColor: AppConfig.primaryWhite,
                      fontColor: AppConfig.primaryBackgroundColorRed,
                      border: Border.all(
                          color: AppConfig.primaryBackgroundColorRed,
                          width: 0.5),
                      fw: null,
                      fontSize: 12.sp,
                      title: _getButtonTitle(order.orderstatus!),
                      onTap: () {})
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getButtonTitle(int orderstatus) {
    var buttonTitle = '删除订单';
    switch (orderstatus) {
      case 10:
        buttonTitle = '立即支付';
        break;

      case 30:
        buttonTitle = '提醒发货';
        break;
      // case 3:
      //   //  buttonTitle
      //   break;
      case 60:
        buttonTitle = '评价';
        break;
      default:
    }
    return buttonTitle;
  }
}

class OrderListSettlementGoodsItemWidget extends StatelessWidget {
  const OrderListSettlementGoodsItemWidget(this.goods, {super.key});

  final List<ApiOrderListItemGoods> goods;

  @override
  Widget build(BuildContext context) {
    if (goods.length > 1) {
      var total = goods.fold(
          0, (previousValue, element) => previousValue + (element.n ?? 0));
      return Row(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              children: goods.take(3).map((e) {
                return CustomCachedNetworkImageWidget(
                    width: MediaQuery.of(context).size.width * 0.2,
                    imageUrl: e.gpurl!);
              }).toList(),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Row(
              children: [
                Text(
                  '共$total件商品',
                  style: AppTextStyle.appTextStyle(
                      color: AppConfig.primaryTextColorBlack),
                ),
                Icon(
                  Icons.chevron_right,
                  color: AppConfig.thirdColorGrey,
                )
              ],
            ),
          )
        ],
      );
    } else {
      if (goods.isEmpty) {
        return SizedBox.shrink();
      } else {
        var curGoods = goods.first;
        return Row(
          children: [
            Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                      CustomCachedNetworkImageWidget(imageUrl: curGoods.gpurl!),
                )),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 1,
                        child: Text(
                          curGoods.gn!,
                          style: AppTextStyle.appTextStyle(
                              color: AppConfig.primaryTextColorBlack,
                              size: 13.sp),
                        )),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '¥${curGoods.sumprice!}',
                            style: AppTextStyle.appTextStyle(
                                color: AppConfig.primaryBackgroundColorRed,
                                size: 12.sp),
                          ),
                          Text(
                            'x${curGoods.n}',
                            style: AppTextStyle.appTextStyle(size: 10.sp),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }
    }
  }
}

// class OrderListsTabWidget extends StatelessWidget {
//   const OrderListsTabWidget(
//     this.title,
//     this.count, {
//     super.key,
//   });

//   final String title;
//   final int count;

//   @override
//   Widget build(BuildContext context) {
//     return Tab(
//       // text: '全部',
//       child: Badge(
//         isLabelVisible: count > 0,
//         alignment:
//             AlignmentDirectional(MediaQuery.of(context).size.width * 0.1, -4),
//         label: Text('$count'),
//         child: Container(
//             alignment: Alignment.center,
//             height: MediaQuery.of(context).size.height * 0.03,
//             width: MediaQuery.of(context).size.width * 0.18,
//             child: Text(title)),
//       ),
//     );
//   }
// }

class OrderListTitleModel {
  final String title;
  final int index;
  const OrderListTitleModel(this.title, this.index);
}
