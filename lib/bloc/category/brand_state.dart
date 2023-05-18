part of 'brand_bloc.dart';

abstract class BrandState extends Equatable {
  const BrandState();

  @override
  List<Object> get props => [];
}

class BrandInitial extends BrandState {}

class BrandLoadingState extends BrandState {}

class BrandLoadedState extends BrandState {
  final ProductBrandModel model;
  const BrandLoadedState(this.model);
}

class BrandErrorState extends BrandState {
  final String msg;
  const BrandErrorState(this.msg);
}
