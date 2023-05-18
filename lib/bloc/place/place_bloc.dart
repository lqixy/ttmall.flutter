import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:ttmall/models/home/api_request/api_recommend.dart';
import 'package:ttmall/models/recommend/recommend_model.dart';

import 'package:ttmall/repositories/recommend/recommend_repository.dart';
import 'package:ttmall/screens/topic/topic.dart';
import 'package:ttmall/utils/route_config.dart';

import '../../models/place/place_model.dart';

part 'place_event.dart';
part 'place_state.dart';

class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {
  final RecommendRepository repository =
      GetIt.instance.get<RecommendRepository>();
  PlaceBloc() : super(PlaceInitial()) {
    on<PlaceLoadEvent>(_loadEvent);

    on<PlaceJumpToEvent>(_jumpToEvent);
  }

  FutureOr<void> _loadEvent(
      PlaceLoadEvent event, Emitter<PlaceState> emit) async {
    const titles = [
      '轮播图',
      '分类推荐',
      '尖货秒杀',
      '活动专区',
      '精选品牌',
      '大图推荐1',
      '大图推荐1_商品列表',
      '大图推荐2',
      '大图推荐2_商品列表',
      '大图推荐3',
      '大图推荐3_商品列表',
      '大图推荐4',
      '大图推荐4_商品列表',
      '热门推荐'
    ];

    // List<RecommendModel> recommends = [];
    emit(PlaceLoadingState());
    try {
      var futures = titles.map((title) => repository.getV2(
          request: ApiRecommendRequest(placename: '${event.title}.$title')));

      var recommends = await Future.wait(futures);

      if (recommends.isNotEmpty) {
        // List<PlaceLargeRecommendModel> larges = [
        //   PlaceLargeRecommendModel(
        //     recommends[5],
        //     recommends[6],
        //   ),
        //   PlaceLargeRecommendModel(
        //     recommends[7],
        //     recommends[8],
        //   ),
        //   PlaceLargeRecommendModel(
        //     recommends[9],
        //     recommends[10],
        //   ),
        //   PlaceLargeRecommendModel(
        //     recommends[11],
        //     recommends[12],
        //   ),
        // ];
        PlaceModel model = PlaceModel(
            recommends[0],
            recommends[1],
            recommends[2],
            recommends[3],
            recommends[4],
            recommends[5],
            recommends[6],
            recommends[7],
            recommends[8],
            recommends[9],
            recommends[10],
            recommends[11],
            recommends[12],
            recommends[13]);
        emit(PlaceLoadedState(model));
      }
    } catch (e) {
      emit(PlaceErrorState(e.toString()));
    }
  }

  FutureOr<void> _jumpToEvent(
      PlaceJumpToEvent event, Emitter<PlaceState> emit) async {
    Navigator.push(
        event.context,
        MaterialPageRoute(
          builder: (context) => TopicScreen(event.topicCode),
        ));
  }
}
