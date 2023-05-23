import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:ttmall/models/cart/api/request/api_cart_add_request.dart';
import 'package:ttmall/models/cart/cart_model.dart';
import 'package:ttmall/repositories/cart/cart_repository.dart';
import 'package:ttmall/shared/dependencies.dart';

import '../../models/cart/api/request/api_cart_update_request.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository repository;

  CartBloc(this.repository) : super(CartInitial()) {
    on<CartLoadEvent>(_loadEvent);

    on<CartInsertEvent>(
      (event, emit) async {
        await repository.add(ApiCartAddRequest(goods: [
          ApiCartGoodsImte(itemid: event.goodsId, type: 10, buycount: 1)
        ]));
      },
    );

    on<CartUpdateEvent>(
      (event, emit) async {
        await repository.update(ApiCartUpdateRequest(goods: [
          ApiCartGoodsImte(
              itemid: event.itemId, type: 10, buycount: event.count)
        ]));
      },
    );

    on<CartCountEvent>(
      (event, emit) async {
        var response = await repository.getCount();
        emit(CartCountState(response.count!));
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
