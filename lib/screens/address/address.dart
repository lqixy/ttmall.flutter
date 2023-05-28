import 'package:ttmall/bloc/navigator/navigator_bloc.dart';
import 'package:ttmall/models/pickup/pick_address_model.dart';
import 'package:ttmall/shared/custom_button_widget.dart';
import 'package:ttmall/shared/custom_error_widget.dart';
import 'package:ttmall/shared/custom_loading_circle_widget.dart';
import 'package:ttmall/shared/custom_sizedbox_widget.dart';
import 'package:ttmall/shared/dependencies.dart';
import 'package:ttmall/utils/app_config.dart';
import 'package:ttmall/utils/route_config.dart';

import '../../bloc/address/address_bloc.dart';
import '../../models/address/address_model.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AddressBloc>().add(AddressLoadEvent());
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppConfig.primaryBackgroundColorGrey,
        appBar: AppBar(
          backgroundColor: AppConfig.primaryWhite,
          elevation: 0,
          title: Text(
            '选择配送方式',
            style: AppTextStyle.appTextStyle(
                color: AppConfig.primaryTextColorBlack, size: 14.sp),
          ),
          centerTitle: true,
          foregroundColor: AppConfig.secondBackgroundColorGrey,
          bottom: const TabBar(
              labelColor: AppConfig.primaryTextColorBlack,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: AppConfig.primaryBackgroundColorRed,
              tabs: [
                Tab(
                  text: '快递配送',
                ),
                Tab(
                  text: '上门自提',
                ),
              ]),
        ),
        body: BlocBuilder<AddressBloc, AddressState>(
          builder: (context, state) {
            if (state is AddressLoadedState) {
              var address = state.list.firstWhere(
                (element) => element.isdefault == '1',
              );
              return TabBarView(children: [
                SingleChildScrollView(
                  child: Column(
                    children:
                        state.list.map((e) => AddressItemWidget(e)).toList(),
                  ),
                ),
                PickAddressWidget(state.pickAddressModel.list!, address),
              ]);
            } else {
              return const TabBarView(children: [
                Center(
                  child: Text('地址'),
                ),
                Center(
                  child: Text('自提'),
                )
              ]);
            }
          },
        ),
        // bottomNavigationBar: SafeArea(
        //   child: CustomButtonWidget(
        //       height: MediaQuery.of(context).size.height * 0.06,
        //       borderRadius: 0,
        //       title: '新增收货地址',
        //       onTap: () {}),
        // ),
      ),
    );
  }
}

class PickAddressWidget extends StatefulWidget {
  const PickAddressWidget(this.list, this.model, {super.key});

  final List<PickAddressItemModel> list;
  final AddressModel model;

  @override
  State<PickAddressWidget> createState() => _PickAddressWidgetState();
}

class _PickAddressWidgetState extends State<PickAddressWidget> {
  late String selectedId = '';

  late final TextEditingController _nameController =
      TextEditingController(text: widget.model.name);
  late final TextEditingController _mobileController =
      TextEditingController(text: widget.model.phone);

  // @override
  // void initState() {
  //   super.initState();

  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                height: MediaQuery.of(context).size.height * 0.04,
                width: MediaQuery.of(context).size.width,
                color: AppConfig.primaryColorPink,
                child: Text(
                  '  自提点有货时，可以直接取货；无货时，需要等待仓库配货',
                  style: AppTextStyle.appTextStyle(
                      color: AppConfig.primaryBackgroundColorRed, size: 11.sp),
                ),
              ),
              Column(
                  children: widget.list
                      .map(
                        (e) => Container(
                          height: MediaQuery.of(context).size.height * 0.14,
                          color: AppConfig.primaryWhite,
                          child: Column(
                            children: [
                              const Custom5SizedboxWidget(),
                              Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Checkbox(
                                          shape: CircleBorder(),
                                          activeColor: AppConfig
                                              .primaryBackgroundColorRed,
                                          value: selectedId == e.pickid,
                                          onChanged: (value) {
                                            if (value!) {
                                              setState(() {
                                                selectedId = e.pickid!;
                                              });
                                            }
                                          })),
                                  Expanded(
                                    flex: 8,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: EdgeInsets.only(top: 8),
                                            child: Text(
                                              e.pickname!,
                                              style: AppTextStyle.appTextStyle(
                                                  color: AppConfig
                                                      .primaryTextColorBlack,
                                                  fw: FontWeight.bold),
                                            )),
                                        Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: EdgeInsets.only(top: 8),
                                            child: Text(
                                              e.pickaddress!,
                                              style: AppTextStyle.appTextStyle(
                                                  color: AppConfig
                                                      .primaryTextColorBlack,
                                                  size: 12.sp),
                                            )),
                                        Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: EdgeInsets.only(top: 8),
                                            child: Text(
                                              e.remark!,
                                              style: AppTextStyle.appTextStyle(
                                                  color: Colors.grey,
                                                  size: 12.sp),
                                            )),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                      flex: 1, child: Icon(Icons.location_on))
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList()),
            ],
          ),
        ),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.1,
                color: AppConfig.primaryWhite,
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                          padding: EdgeInsets.only(top: 8, left: 8),
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            '提货人信息',
                            style: AppTextStyle.appTextStyle(
                                color: AppConfig.primaryTextColorBlack,
                                fw: FontWeight.bold,
                                size: 12.sp),
                          )),
                    ),
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 4, bottom: 4, left: 8, right: 4),
                              child: Container(
                                  color: AppConfig.secondColorGrey,
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  child: TextField(
                                    controller: _nameController,
                                    decoration: InputDecoration(
                                        border: InputBorder.none),
                                  )),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 4, bottom: 4, left: 4, right: 4),
                              child: Container(
                                  color: AppConfig.secondColorGrey,
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  child: TextField(
                                    controller: _mobileController,
                                    decoration: InputDecoration(
                                        border: InputBorder.none),
                                  )),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 4, bottom: 4, left: 2, right: 4),
                              child: CustomButtonWidget(
                                  borderRadius: 0,
                                  backgroundColor: selectedId.isEmpty
                                      ? AppConfig.secondBackgroundColorGrey
                                      : AppConfig.primaryBackgroundColorRed,
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  title: '确认',
                                  onTap: () {}),
                            ),
                          ),
                          // TextButton(
                          //     onPressed: () {}, child: Text('确认')),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ))
      ],
    );
  }
}

// class AddressScreen extends StatefulWidget {
//   const AddressScreen(this.selectedId, {super.key});
//   final String selectedId;
//   @override
//   State<AddressScreen> createState() => _AddressScreenState();
// }

// class _AddressScreenState extends State<AddressScreen> {
//   // String checkedId = '';

//   @override
//   void initState() {
//     super.initState();
//     context.read<AddressBloc>().add(AddressLoadEvent());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         backgroundColor: AppConfig.primaryBackgroundColorGrey,
//         appBar: AppBar(
//           backgroundColor: AppConfig.primaryWhite,
//           elevation: 0,
//           title: Text(
//             '选择配送方式',
//             style: AppTextStyle.appTextStyle(
//                 color: AppConfig.primaryTextColorBlack, size: 14.sp),
//           ),
//           centerTitle: true,
//           foregroundColor: AppConfig.secondBackgroundColorGrey,
//           bottom: const TabBar(
//               labelColor: AppConfig.primaryTextColorBlack,
//               indicatorSize: TabBarIndicatorSize.label,
//               indicatorColor: AppConfig.primaryBackgroundColorRed,
//               tabs: [
//                 Tab(
//                   text: '快递配送',
//                 ),
//                 Tab(
//                   text: '上门自提',
//                 ),
//               ]),
//         ),
//         body: TabBarView(children: [
//           SingleChildScrollView(
//             child: BlocBuilder<AddressBloc, AddressState>(
//               builder: (context, state) {
//                 if (state is AddressLoadedState) {
//                   return Column(
//                     children:
//                         state.list.map((e) => AddressItemWidget(e)).toList(),
//                   );
//                 } else if (state is AddressErrorState) {
//                   return CustomErrorWidget(state.msg);
//                 } else {
//                   return const CustomLoadingCircleWidget();
//                 }
//               },
//             ),
//           ),
//           const Center(
//             child: Text('自提'),
//           )
//         ]),
//         bottomNavigationBar: SafeArea(
//           child: CustomButtonWidget(
//               height: MediaQuery.of(context).size.height * 0.06,
//               borderRadius: 0,
//               title: '新增收货地址',
//               onTap: () {}),
//         ),
//       ),
//     );
//   }
// }

class AddressItemWidget extends StatelessWidget {
  const AddressItemWidget(
    this.model, {
    super.key,
  });

  final AddressModel model;

  void _setDefault(BuildContext context) {
    BlocProvider.of<AddressBloc>(context)
        .add(AddressSetDefaultEvent(model.addrid!));

    BlocProvider.of<NavigatorBloc>(context).add(NavigatorPopEvent(context));
    BlocProvider.of<NavigatorBloc>(context).add(NavigatorPopEvent(context));
    BlocProvider.of<NavigatorBloc>(context)
        .add(NavigatorPushNamedEvent(context, RouteConfig.OrderConfirm));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Custom5SizedboxWidget(),
        Container(
          height: MediaQuery.of(context).size.height * 0.19,
          color: AppConfig.primaryWhite,
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: SizedBox(
                  // padding: EdgeInsets.symmetric(vertical: 8),
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    '${model.name}     ${model.phone}',
                    style: AppTextStyle.appTextStyle(
                        color: AppConfig.primaryTextColorBlack,
                        size: 14.sp,
                        fw: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: SizedBox(
                  // padding: EdgeInsets.symmetric(vertical: 8),
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    '地址: ${model.addressDetail}',
                    style: AppTextStyle.appTextStyle(
                        color: AppConfig.primaryTextColorBlack, size: 12.sp),
                  ),
                ),
              ),
              const Expanded(flex: 1, child: Divider()),
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Checkbox(
                            shape: const CircleBorder(),
                            activeColor: AppConfig.primaryBackgroundColorRed,
                            value: model.isdefault == '1',
                            onChanged: (value) {
                              _setDefault(context);
                            })),
                    Expanded(
                        flex: 10,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              _setDefault(context);
                            },
                            child: Text(
                              '选择地址',
                              style: AppTextStyle.appTextStyle(
                                  color: AppConfig.secondTextColorGery,
                                  size: 12.sp),
                            ),
                          ),
                        )),
                    Expanded(
                        flex: 1,
                        child: Image(
                            height: 16.h,
                            image: const AssetImage('assets/images/edit.png'))),
                    const Expanded(flex: 2, child: Text('编辑')),
                    Expanded(
                        flex: 1,
                        child: Image(
                            height: 16.sp,
                            image: const AssetImage('assets/images/del.png'))),
                    const Expanded(flex: 2, child: Text('删除')),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
