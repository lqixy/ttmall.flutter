part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoadedState extends CategoryState {
  final ProductCategoryModel model;
  final HotRecommendModel hotRecommendModel;
  const CategoryLoadedState(this.model, this.hotRecommendModel);
}

class CategoryErrorState extends CategoryState {
  final String msg;
  const CategoryErrorState(this.msg);
}
