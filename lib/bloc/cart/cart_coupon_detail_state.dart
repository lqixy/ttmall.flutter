part of 'cart_coupon_detail_bloc.dart';

abstract class CartCouponDetailState extends Equatable {
  const CartCouponDetailState();

  @override
  List<Object> get props => [];
}

class CartCouponDetailInitial extends CartCouponDetailState {}

class CartCouponDetailLoadedState extends CartCouponDetailState {
  final CartModel model;
  const CartCouponDetailLoadedState(this.model);
}

class CartCouponDetailErrorState extends CartCouponDetailState {
  final String msg;
  const CartCouponDetailErrorState(this.msg);
}
