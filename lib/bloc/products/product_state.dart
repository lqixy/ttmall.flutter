part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductErrorState extends ProductState {
  String msg;
  ProductErrorState({this.msg = ''});
}

class ProductLoadedState extends ProductState {
  ProductInfoModel model;
  ReceiptServiceModel serviceModel;
  ProductInfoRecommendGoodsModel goods;
  List<ProdetailImageModel> images;
  // ProdetailCommentModel prodetailCommentModel;
  ProductLoadedState({
    required this.model,
    required this.serviceModel,
    required this.goods,
    required this.images,
    // required this.prodetailCommentModel
  });
}
