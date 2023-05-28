import 'package:get_it/get_it.dart';
import 'package:nested/nested.dart';
import 'package:ttmall/bloc/address/address_bloc.dart';

import 'package:ttmall/bloc/cart/cart_bloc.dart';
import 'package:ttmall/bloc/cart/cart_counter_bloc.dart';
import 'package:ttmall/bloc/cart/cart_coupon_detail_bloc.dart';

import 'package:ttmall/bloc/category/brand_bloc.dart';
import 'package:ttmall/bloc/dic/dic_bloc.dart';
import 'package:ttmall/bloc/login/login_bloc.dart';
import 'package:ttmall/bloc/more_popup/more_popup_bloc.dart';
import 'package:ttmall/bloc/navigator/navigator_bloc.dart';
import 'package:ttmall/bloc/orders/confirm/order_confirm_bloc.dart';
import 'package:ttmall/bloc/orders/lists/order_lists_bloc.dart';
import 'package:ttmall/bloc/orders/order_bloc.dart';
import 'package:ttmall/bloc/place/place_bloc.dart';
import 'package:ttmall/bloc/products/comments_bloc.dart';
import 'package:ttmall/bloc/products/product_bloc.dart';
import 'package:ttmall/bloc/topic/topic_bloc.dart';
import 'package:ttmall/bloc/user/user_bloc.dart';
import 'package:ttmall/repositories/address/address_repository.dart';
import 'package:ttmall/repositories/cart/cart_repository.dart';
import 'package:ttmall/repositories/category/brand_repository.dart';
import 'package:ttmall/repositories/category/category_repository.dart';
import 'package:ttmall/repositories/comments/comments_repository.dart';
import 'package:ttmall/repositories/dic/dic_repository.dart';
import 'package:ttmall/repositories/login/login_repository.dart';
import 'package:ttmall/repositories/orders/order_confirm_repository.dart';
import 'package:ttmall/repositories/orders/order_repository.dart';
import 'package:ttmall/repositories/pickup/pick_repository.dart';
import 'package:ttmall/repositories/products/product_repository.dart';
import 'package:ttmall/repositories/recommend/recommend_repository.dart';
import 'package:ttmall/repositories/topic/topic_repository.dart';
import 'package:ttmall/repositories/user/user_repository.dart';
import 'package:ttmall/screens/checkout/checkout.dart';
import 'package:ttmall/screens/demo/demo.dart';
import 'package:ttmall/screens/orders/cancel/order_cancel.dart';
import 'package:ttmall/screens/orders/confirm/order_confirm_screen.dart';
import 'package:ttmall/screens/orders/detail/order_detail.dart';
import 'package:ttmall/screens/orders/lists/order_lists.dart';

import 'package:ttmall/services/jsp_util.dart';

import 'package:ttmall/utils/route_config.dart';

import 'bloc/category/category_bloc.dart';
import 'shared/dependencies.dart';
import 'package:ttmall/bloc/bottom_nav/bottom_nav_bloc.dart';
import 'package:ttmall/bloc/home/home_bloc.dart';

import 'package:ttmall/bloc/main/main_bloc.dart';
import 'package:ttmall/bloc/profile/profile_bloc.dart';
import 'package:ttmall/repositories/home/index_banner_repository.dart';

import 'package:ttmall/screens/cart/cart.dart';
import 'package:ttmall/screens/category/category.dart';
import 'package:ttmall/screens/home/home.dart';
import 'package:ttmall/screens/login/login.dart';
import 'package:ttmall/screens/place/place.dart';
import 'package:ttmall/screens/profile/profile.dart';
import 'package:ttmall/screens/search/search.dart';

// import 'package:hive/hive.dart';

void main() async {
  //初始化Hive
  WidgetsFlutterBinding.ensureInitialized();
  GetIt locator = GetIt.instance;
  _registerRepositories(locator);
  await JSpUtil.instance.init();

  ErrorWidget.builder = (details) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        'Error\n${details.exception}',
      ),
    );
  };

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => MultiBlocProvider(
          providers: _getProviders,
          child: MaterialApp(
            // builder: FToastBuilder(),
            initialRoute: RouteConfig.Home,
            routes: _getRoutes,
            debugShowCheckedModeBanner: false,
            // home: HomeScreen(),
          )),
    );
  }

  Map<String, WidgetBuilder> get _getRoutes {
    return {
      '/': (context) => const HomeScreen(),
      '/cart': (context) => const CartScreen(),
      '/profile': (context) => ProfileScreen(),
      '/place': (context) => const PlaceScreen(),
      // '/product': (context) => const ProductScreen(''),
      '/login': (context) => LoginScreen(),
      '/category': (context) => const CategoryScreen(),
      '/search': (context) => const SearchScreen(),
      '/demo': (context) => DemoScreen(),
      RouteConfig.OrderConfirm: (context) => const OrderConfirmScreen(),
      RouteConfig.Checkout: (context) => const CheckoutScreen(),
      // RouteConfig.OrderLists: (context) => OrderListsScreen(),
      // RouteConfig.OrderDetail: (context) =>
      //     OrderDetailScreen('b650cb03-5c21-4199-86f6-9002c2f00fdd'),
      // RouteConfig.OrderCancel: (context) => OrderCancelScreen(''),
    };
  }

  List<SingleChildWidget> get _getProviders {
    return [
      BlocProvider<BottomNavBloc>(
        create: (context) => BottomNavBloc(),
      ),
      BlocProvider<MainBloc>(
        create: (context) => MainBloc(),
      ),
      BlocProvider<ProfileBloc>(
        create: (context) => ProfileBloc(),
      ),
      BlocProvider<HomeBloc>(
        create: (context) => HomeBloc(),
      ),
      BlocProvider<ProductBloc>(create: (context) => ProductBloc()),
      BlocProvider<CommentsBloc>(
        create: (context) => CommentsBloc(repository: CommentsRepository()),
      ),
      BlocProvider<MorePopupBloc>(
        create: (context) => MorePopupBloc(),
      ),
      BlocProvider<CategoryBloc>(
        create: (context) => CategoryBloc(),
      ),
      BlocProvider<BrandBloc>(
        create: (context) => BrandBloc(BrandRepository()),
      ),
      BlocProvider<CartBloc>(
        create: (context) => CartBloc(),
      ),
      BlocProvider<CartCounterBloc>(
        create: (context) => CartCounterBloc(),
      ),
      BlocProvider<CartCouponDetailBloc>(
        create: (context) => CartCouponDetailBloc(),
      ),
      BlocProvider<OrderConfirmBloc>(
        create: (context) => OrderConfirmBloc(),
      ),
      BlocProvider<PlaceBloc>(
        create: (context) => PlaceBloc(),
      ),
      BlocProvider<TopicBloc>(
        create: (context) => TopicBloc(),
      ),
      BlocProvider<NavigatorBloc>(
        create: (context) => NavigatorBloc(),
      ),
      BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(),
      ),
      BlocProvider<AddressBloc>(
        create: (context) => AddressBloc(),
      ),
      BlocProvider<OrderBloc>(
        create: (context) => OrderBloc(),
      ),
      BlocProvider<UserBloc>(
        create: (context) => UserBloc(),
      ),
      BlocProvider<OrderListsBloc>(
        create: (context) => OrderListsBloc(),
      ),
      BlocProvider<DicBloc>(
        create: (context) => DicBloc(),
      ),
    ];
  }
}

void _registerRepositories(GetIt locator) {
  locator.registerLazySingleton<CategoryRepository>(
    () => CategoryRepository(),
  );

  locator
      .registerLazySingleton<RecommendRepository>(() => RecommendRepository());
  locator.registerLazySingleton<IndexBannerRepository>(
      () => IndexBannerRepository());

  locator.registerLazySingleton<ProductRepository>(() => ProductRepository());

  locator.registerLazySingleton<CartRepository>(
    () => CartRepository(),
  );

  locator.registerLazySingleton<OrderConfirmRepository>(
      () => OrderConfirmRepository());

  locator.registerLazySingleton<TopicRepository>(() => TopicRepository());

  locator.registerLazySingleton<LoginRepository>(
    () => LoginRepository(),
  );

  locator.registerLazySingleton<AddressRepository>(() => AddressRepository());

  locator.registerLazySingleton<PickRepository>(() => PickRepository());

  locator.registerLazySingleton<OrderRepository>(() => OrderRepository());

  locator.registerLazySingleton<UserRepository>(() => UserRepository());

  locator.registerLazySingleton<DicRepository>(() => DicRepository());
}
