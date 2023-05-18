import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ttmall/models/products/prodetail_comment_model.dart';
import 'package:ttmall/repositories/comments/comments_repository.dart';

part 'comments_event.dart';
part 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  CommentsRepository repository;
  List<CommentModel> _data = [];
  CommentsBloc({required this.repository}) : super(const CommentsState()) {
    // on<CommentsEvent>((event, emit) async {
    //   // print('init');
    //   try {
    //     var model = await repository.getComment();
    //       _data.addAll(model.list!);

    //       // model.list = _data;
    //       // emit(CommentsLoadedState(
    //       //     models: model.list!, buttonlist: model.buttonlist!));
    //       emit(state.copyWith(
    //         models: _data,
    //         buttonlist: model.buttonlist,
    //       ));
    //   } catch (e) {
    //     emit(CommentsErrorState(e.toString()));
    //   }
    // });
    on<CommentsLoadingEvent>(
      (event, emit) async {
        try {
          var model = await repository.getComment();
          _data.addAll(model.list!);

          // model.list = _data;
          // emit(CommentsLoadedState(
          //     models: model.list!, buttonlist: model.buttonlist!));
          emit(state.copyWith(
            models: _data,
            status: BlocStatus.loaded,
            buttonlist: model.buttonlist,
          ));
        } catch (e) {
          emit(CommentsErrorState(e.toString()));
        }
      },
    );
  }
}
