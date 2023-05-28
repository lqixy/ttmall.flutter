part of 'cart_coupon_detail_bloc.dart';

abstract class CartCouponDetailEvent extends Equatable {
  const CartCouponDetailEvent();

  @override
  List<Object> get props => [];
}

class CartCouponDetailLoadEvent extends CartCouponDetailEvent {}
