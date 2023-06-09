import 'dart:async';
import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ttmall/models/home/api_request/api_recommend.dart';
import 'package:ttmall/models/home/api_request/apii_indexbanner_request.dart';
import 'package:ttmall/models/home/index_banner_model.dart';

import 'package:ttmall/repositories/home/index_banner_repository.dart';

import 'package:ttmall/screens/place/place.dart';

import '../../models/recommend/recommend_model.dart';
import '../../repositories/recommend/recommend_repository.dart';
import '../../screens/products/product.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  late RecommendRepository repository =
      GetIt.instance.get<RecommendRepository>();
  late IndexBannerRepository bannerRepository =
      GetIt.instance.get<IndexBannerRepository>();

  HomeBloc() : super(HomeInitial()) {
    on<HomeLoadEvent>(_homeLoadEvent);

    on<HomeNavToPlaceEvent>(_navToPlaceEvent);
  }

  FutureOr<void> _homeLoadEvent(event, emit) async {
    emit(HomeLoadingState());
    try {
      final list = await repository.getV4();
      final model = await bannerRepository.getAsync();
      emit(HomeLoadedState(list, model));
    } catch (e) {
      emit(HomeErrorState(e.toString()));
    }
    // print('load');
  }

  void _navToPlaceEvent(HomeNavToPlaceEvent event, Emitter emit) {
    Navigator.push(
        event.context,
        MaterialPageRoute(
          builder: (context) => PlaceScreen(
            placeName: event.placeName,
          ),
        ));
  }

  // FutureOr<void> _checkEvent(
  //     HomeCheckEvent event, Emitter<HomeState> emit) async {
  //   var deviceInfo = DeviceInfoPlugin();
  //   if (Theme.of(event.context).platform == TargetPlatform.android) {
  //     var androidInfo = await deviceInfo.androidInfo;
  //     print(androidInfo.model);
  //   } else if (Theme.of(event.context).platform == TargetPlatform.iOS) {
  //     var iosInfo = await deviceInfo.iosInfo;
  //     print(iosInfo.model);
  //   }
  // }
}
