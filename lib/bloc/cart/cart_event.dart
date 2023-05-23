part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartLoadEvent extends CartEvent {}

// class CartGotoEvent extends CartEvent {
//   final BuildContext context;
//   final String routeName;
//   const CartGotoEvent(this.context, this.routeName);
// }

class CartInsertEvent extends CartEvent {
  final String goodsId;
  const CartInsertEvent(this.goodsId);
}

class CartUpdateEvent extends CartEvent {
  final int count;
  final String itemId;
  const CartUpdateEvent(this.itemId, this.count);
}

class CartCountEvent extends CartEvent {
  // final int count;
  // const CartCountEvent(this.count);
}
