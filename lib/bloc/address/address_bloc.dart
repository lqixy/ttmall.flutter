import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:ttmall/models/address/address_model.dart';
import 'package:ttmall/models/pickup/pick_address_model.dart';
import 'package:ttmall/repositories/address/address_repository.dart';

import '../../repositories/pickup/pick_repository.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  var repository = GetIt.instance.get<AddressRepository>();
  var pickRepository = GetIt.instance.get<PickRepository>();
  AddressBloc() : super(AddressInitial()) {
    on<AddressLoadEvent>(
      (event, emit) async {
        emit(AddressLoadingState());
        try {
          var response = await repository.get();
          var pick = await pickRepository.get();
          emit(AddressLoadedState(response.list!, pick));
        } catch (e) {
          emit(AddressErrorState(e.toString()));
        }
      },
    );

    on<AddressSetDefaultEvent>(
      (event, emit) async {
        try {
          await repository.setDefault(event.addressId);

          // emit(AddressSetDefaultSuccessState());
        } catch (e) {
          emit(AddressSetDefaultErrorState(e.toString()));
        }
      },
    );
  }
}
