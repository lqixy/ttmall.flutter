import 'package:get_it/get_it.dart';

import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:ttmall/services/jsp_util.dart';
import 'package:ttmall/shared/custom_badge_widget.dart';

import 'package:ttmall/shared/custom_button_widget.dart';
import 'package:ttmall/shared/dependencies.dart';
import 'package:ttmall/utils/app_config.dart';

class DemoScreen extends StatelessWidget {
  const DemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connectivity Checker'),
      ),
      // body: Center(
      //   child: Badge(
      //     // alignment: AlignmentDirectional.topEnd,
      //     label: Text('2'),
      //     child: Container(
      //         color: AppConfig.primaryBackgroundColorRed,
      //         // height: MediaQuery.of(context).size.height * 0.06,
      //         // width: MediaQuery.of(context).size.width * 0.06,
      //         child: Icon(Icons.person)),
      //   ),
      // ),
    );
  }
}

// class DemoScreen extends StatefulWidget {
//   const DemoScreen({super.key});

//   @override
//   State<DemoScreen> createState() => _DemoScreenState();
// }

// class _DemoScreenState extends State<DemoScreen> {
//   final ItemScrollController _itemScrollController = ItemScrollController();

//   late final TextEditingController _controller =
//       TextEditingController(text: '1');
//   @override
//   void initState() {
//     super.initState();
//     // _controller = TextEditingController(text: '1');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             TextField(
//               textAlign: TextAlign.center,
//               controller: _controller,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 CustomButtonWidget(
//                     height: 46.h,
//                     width: 46.w,
//                     title: '-',
//                     onTap: () {
//                       var countStr = _controller.text;
//                       var count = int.tryParse(countStr);
//                       if (count == null || count <= 1) {
//                         _controller.text = '1';
//                       } else {
//                         _controller.text = '${count - 1}';
//                       }
//                       // _controller.text = '-';
//                     }),
//                 CustomButtonWidget(
//                     height: 46.h,
//                     width: 46.w,
//                     title: '+',
//                     onTap: () {
//                       var countStr = _controller.text;
//                       var count = int.tryParse(countStr);
//                       if (count == null || count < 1) {
//                         _controller.text = '1';
//                       } else {
//                         _controller.text = '${count + 1}';
//                       }
//                       // _controller.text = '-';
//                     }),
//                 CustomButtonWidget(
//                     height: 46.h,
//                     width: 46.w,
//                     title: 'save',
//                     onTap: () {
//                       JSpUtil.instance.setString('count', _controller.text);
//                       // _controller.text = '-';
//                     }),
//                 CustomButtonWidget(
//                     height: 46.h,
//                     width: 46.w,
//                     title: 'get',
//                     onTap: () {
//                       var count = JSpUtil.instance.getString(
//                         'count',
//                       );
//                       print(count); // _controller.text = '-';
//                     }),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// Scaffold(
//       backgroundColor: AppConfig.primaryWhite,
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             backgroundColor: AppConfig.primaryWhite,
//             foregroundColor: AppConfig.secondColorGrey,
//             title: SizedBox(
//                 height: 30.h,
//                 width: MediaQuery.of(context).size.width * 0.6,
//                 child: TextField(
//                   cursorColor: AppConfig.secondColorGrey,
//                   decoration: InputDecoration(
//                       prefixIcon: Icon(Ionicons.search_outline),
//                       prefixIconColor: AppConfig.secondColorGrey,
//                       border: OutlineInputBorder(),
//                       focusColor: AppConfig.primaryBackgroundColorGrey,
//                       focusedBorder: OutlineInputBorder(
//                           borderSide:
//                               BorderSide(color: AppConfig.secondColorGrey))),
//                 )),
//             expandedHeight: 30.h,
//             floating: false,
//             pinned: true,
//             actions: [
//               Container(
//                 padding: EdgeInsets.only(right: 14.w),
//                 child: CircleAvatar(
//                   backgroundColor: AppConfig.primaryWhite,
//                   child: Icon(
//                     Ionicons.person_circle_outline,
//                     color: AppConfig.secondColorGrey,
//                     size: 30.sp,
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ],
//       ),
//     );


//// 上拉展示更多
// class CategoryScreen extends StatefulWidget {
//   const CategoryScreen({super.key});

//   @override
//   State<CategoryScreen> createState() => _CategoryScreenState();
// }

// class _CategoryScreenState extends State<CategoryScreen> {
//   final ScrollController _scrollController = ScrollController();

//   // final CategoryBloc _bloc = context.read<CategoryBloc>();
//   CategoryBloc? _bloc;

//   @override
//   void initState() {
//     super.initState();

//     _scrollController.addListener(_onScroll);

//     _bloc = context.read<CategoryBloc>();

//     _bloc?.add(CategoryLoadMoreEvent());
//   }

//   void _onScroll() {
//     if (_scrollController.offset >=
//             _scrollController.position.maxScrollExtent &&
//         !_scrollController.position.outOfRange) {
//       _bloc?.add(CategoryLoadMoreEvent());
//     }
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<CategoryBloc, CategoryState>(
//       builder: (context, state) {
//         switch (state.status) {
//           case CategoryStatus.loding:
//             return const CustomLoadingCircleWidget();
//           case CategoryStatus.success:
//             return ListView.builder(
//               controller: _scrollController,
//               itemCount: state.datas.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(state.datas[index]),
//                 );
//               },
//             );
//           case CategoryStatus.error:
//             return const Center(
//               child: Text('no data'),
//             );
//         }
//       },
//     );
//   }
// }
