import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ttmall/models/category/hot_recommend_model.dart';
import 'package:ttmall/models/category/product_category_model.dart';
import 'package:ttmall/repositories/category/category_repository.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository repository;
  CategoryBloc(this.repository) : super(CategoryInitial()) {
    // on<CategoryEvent>((event, emit) {
    //   print('set');
    // });
    on<CategoryLoadingEvent>(_loadingEvent);
  }

  FutureOr<void> _loadingEvent(
      CategoryLoadingEvent event, Emitter<CategoryState> emit) async {
    try {
      var model = await repository.get();
      var hotrecommend = await repository.getHotRecommends();
      emit(CategoryLoadedState(model, hotrecommend));
    } catch (e) {
      emit(CategoryErrorState(e.toString()));
    }
  }
}
