part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class ProductLoadEvent extends ProductEvent {
  final String goodsId;
  const ProductLoadEvent(this.goodsId);
}

class ProductJumpToDetailEvent extends ProductEvent {
  final BuildContext context;
  final String goodsId;
  const ProductJumpToDetailEvent(this.context, this.goodsId);
}
