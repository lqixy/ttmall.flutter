import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:ttmall/models/products/goods_model.dart';
import 'package:ttmall/models/products/prodetail_comment_model.dart';
import 'package:ttmall/models/products/prodetail_image_model.dart';
import 'package:ttmall/models/products/product_info_model.dart';
import 'package:ttmall/models/products/receipt_service.dart';
import 'package:ttmall/repositories/products/product_repository.dart';
import 'package:ttmall/screens/products/product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository = GetIt.instance.get<ProductRepository>();

  ProductBloc() : super(ProductInitial()) {
    on<ProductLoadEvent>(
      (event, emit) async {
        emit(ProductLoadingState());
        try {
          var model = await repository.getAsync(event.goodsId);
          var goods = await repository.getGoods(event.goodsId);
          var images = await repository.getProdetailImages(event.goodsId);
          var serviceModel = await repository.getServices(model.productid!);

          // var prodetailCommentModel = await repository.getComment();
          emit(ProductLoadedState(
            model: model,
            serviceModel: serviceModel,
            goods: goods,
            images: images,
            // prodetailCommentModel: prodetailCommentModel
          ));
        } catch (e) {
          emit(ProductErrorState(msg: e.toString()));
        }
      },
    );

    on<ProductJumpToDetailEvent>(
      (event, emit) {
        Navigator.push(
            event.context,
            MaterialPageRoute(
              builder: (context) => ProductScreen(event.goodsId),
            ));
      },
    );
  }
}
