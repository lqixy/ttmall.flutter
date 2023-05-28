import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:ttmall/repositories/cart/cart_repository.dart';

part 'cart_counter_event.dart';
part 'cart_counter_state.dart';

class CartCounterBloc extends Bloc<CartCounterEvent, CartCounterState> {
  var repository = GetIt.instance.get<CartRepository>();
  CartCounterBloc() : super(CartCounterInitial()) {
    // on<CartCounterEvent>((event, emit) {
    //   // TODO: implement event handler
    // });

    on<CartCounterLoadEvent>(
      (event, emit) async {
        var response = await repository.getCount();
        emit(CartCounterLoadedState(response.count!));
      },
    );
  }
}
