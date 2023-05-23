part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductErrorState extends ProductState {
  final String msg;
  const ProductErrorState(this.msg);
}

class ProductLoadedState extends ProductState {
  final ProductInfoModel model;
  final ReceiptServiceModel serviceModel;
  final ProductInfoRecommendGoodsModel goods;
  final List<ProdetailImageModel> images;
  // final ApiCartCountResponse cartCount;
  final int cartCount;
  // ProdetailCommentModel prodetailCommentModel;
  const ProductLoadedState(
    this.model,
    this.serviceModel,
    this.goods,
    this.images,
    this.cartCount,
    //   {
    //   // required this.model,
    //   // required this.serviceModel,
    //   // required this.goods,
    //   // required this.images,

    //   // required this.prodetailCommentModel
    // }
  );
}
