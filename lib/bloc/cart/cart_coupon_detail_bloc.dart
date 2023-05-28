import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:ttmall/models/cart/cart_model.dart';
import 'package:ttmall/repositories/cart/cart_repository.dart';

part 'cart_coupon_detail_event.dart';
part 'cart_coupon_detail_state.dart';

class CartCouponDetailBloc
    extends Bloc<CartCouponDetailEvent, CartCouponDetailState> {
  var repository = GetIt.instance.get<CartRepository>();

  CartCouponDetailBloc() : super(CartCouponDetailInitial()) {
    // on<CartCouponDetailEvent>((event, emit) {
    //   // TODO: implement event handler
    // });
    on<CartCouponDetailLoadEvent>(
      (event, emit) async {
        try {
          var model = await repository.get();
          emit(CartCouponDetailLoadedState(model));
        } catch (e) {
          emit(CartCouponDetailErrorState(e.toString()));
        }
      },
    );
  }
}
