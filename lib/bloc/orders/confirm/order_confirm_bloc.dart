import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ttmall/models/orders/order_confirm_model.dart';
import 'package:ttmall/repositories/orders/order_confirm_repository.dart';

part 'order_confirm_event.dart';
part 'order_confirm_state.dart';

class OrderConfirmBloc extends Bloc<OrderConfirmEvent, OrderConfirmState> {
  final OrderConfirmRepository repository;
  OrderConfirmBloc(this.repository) : super(OrderConfirmInitial()) {
    on<OrderConfirmLoadEvent>(
      (event, emit) async {
        emit(OrderConfirmLoadingState());
        try {
          var model = await repository.get();
          emit(OrderConfirmLoadedState(model));
        } catch (e) {
          emit(OrderConfirmErrorState(e.toString()));
        }
      },
    );
  }
}
