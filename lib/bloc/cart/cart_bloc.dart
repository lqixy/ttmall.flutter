import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ttmall/models/cart/api/request/api_cart_add_request.dart';
import 'package:ttmall/models/cart/cart_model.dart';
import 'package:ttmall/repositories/cart/cart_repository.dart';
import 'package:ttmall/shared/dependencies.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository repository;

  CartBloc(this.repository) : super(CartInitial()) {
    on<CartLoadEvent>(_loadEvent);

    on<CartGotoEvent>(
      (event, emit) {
        Navigator.pushNamed(event.context, event.routeName);
      },
    );

    on<CartInsertEvent>(
      (event, emit) async {
        await repository.add(ApiCartAddRequest(goods: [
          ApiCartGoodsImte(itemid: event.goodsId, type: 10, buycount: 1)
        ]));
      },
    );
  }

  FutureOr<void> _loadEvent(
      CartLoadEvent event, Emitter<CartState> emit) async {
    emit(CartLoadingState());
    try {
      var model = await repository.get();
      emit(CartLoadedState(model));
    } catch (e) {
      emit(CartErrorState(e.toString()));
    }
  }
}
