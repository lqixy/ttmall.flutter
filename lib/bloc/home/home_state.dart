part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  List<RecommendModel> recommends;
  IndexBannerModel model;
  HomeLoadedState({required this.recommends, required this.model});
}
