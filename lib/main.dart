import 'package:get_it/get_it.dart';
import 'package:nested/nested.dart';

import 'package:ttmall/bloc/cart/cart_bloc.dart';

import 'package:ttmall/bloc/category/brand_bloc.dart';
import 'package:ttmall/bloc/more_popup/more_popup_bloc.dart';
import 'package:ttmall/bloc/navigator/navigator_bloc.dart';
import 'package:ttmall/bloc/orders/confirm/order_confirm_bloc.dart';
import 'package:ttmall/bloc/place/place_bloc.dart';
import 'package:ttmall/bloc/products/comments_bloc.dart';
import 'package:ttmall/bloc/products/product_bloc.dart';
import 'package:ttmall/bloc/topic/topic_bloc.dart';
import 'package:ttmall/repositories/cart/cart_repository.dart';
import 'package:ttmall/repositories/category/brand_repository.dart';
import 'package:ttmall/repositories/category/category_repository.dart';
import 'package:ttmall/repositories/comments/comments_repository.dart';
import 'package:ttmall/repositories/orders/order_confirm_repository.dart';
import 'package:ttmall/repositories/products/product_repository.dart';
import 'package:ttmall/repositories/recommend/recommend_repository.dart';
import 'package:ttmall/repositories/topic/topic_repository.dart';
import 'package:ttmall/screens/demo/demo.dart';
import 'package:ttmall/screens/orders/confirm/order_confirm_screen.dart';

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

void main() {
  //初始化Hive
  WidgetsFlutterBinding.ensureInitialized();
  GetIt locator = GetIt.instance;
  _registerRepositories(locator);
  JSpUtil.instance.init();
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
      '/profile': (context) => const ProfileScreen(),
      '/place': (context) => const PlaceScreen(),
      // '/product': (context) => const ProductScreen(''),
      '/login': (context) => const LoginScreen(),
      '/category': (context) => const CategoryScreen(),
      '/search': (context) => const SearchScreen(),
      '/demo': (context) => const DemoScreen(),
      RouteConfig.OrderConfirm: (context) => const OrderConfirmScreen(),
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
        create: (context) => HomeBloc(
            // repository: RecommendRepository(),
            // bannerRepository: IndexBannerRepository()
            ),
      ),
      BlocProvider<ProductBloc>(create: (context) => ProductBloc()),
      BlocProvider<CommentsBloc>(
        create: (context) => CommentsBloc(repository: CommentsRepository()),
      ),
      BlocProvider<MorePopupBloc>(
        create: (context) => MorePopupBloc(),
      ),
      BlocProvider<CategoryBloc>(
        create: (context) =>
            CategoryBloc(GetIt.instance.get<CategoryRepository>()),
      ),
      BlocProvider<BrandBloc>(
        create: (context) => BrandBloc(BrandRepository()),
      ),
      BlocProvider<CartBloc>(
        create: (context) => CartBloc(GetIt.instance.get<CartRepository>()),
      ),
      BlocProvider<OrderConfirmBloc>(
        create: (context) =>
            OrderConfirmBloc(GetIt.instance.get<OrderConfirmRepository>()),
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

  // locator.registerLazySingleton<HttpService>(() => HttpService());
}
