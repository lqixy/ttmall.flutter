import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ttmall/models/category/product_brand_model.dart';
import 'package:ttmall/repositories/category/brand_repository.dart';

part 'brand_event.dart';
part 'brand_state.dart';

class BrandBloc extends Bloc<BrandEvent, BrandState> {
  final BrandRepository repository;

  BrandBloc(this.repository) : super(BrandInitial()) {
    // on<BrandEvent>((event, emit) {
    //   // TODO: implement event handler
    // });

    on<BrandLoadEvent>(
      (event, emit) async {
        try {
          var model = await repository.get();
          emit(BrandLoadedState(model));
        } catch (e) {
          emit(BrandErrorState(e.toString()));
        }
      },
    );
  }
}
