part of 'comments_bloc.dart';

enum BlocStatus { loading, loaded, error }

class CommentsState extends Equatable {
  // const CommentsState();
  final BlocStatus status;
  final List<CommentModel> models;
  final List<ButtonlistModel> buttonlist;
  final int type;

  const CommentsState(
      {this.models = const [],
      this.buttonlist = const [],
      this.status = BlocStatus.loading,
      this.type = 1});
  // const CommentsLoadedState(this.model, {this.type = 1});
  CommentsState copyWith(
      {List<CommentModel>? models,
      List<ButtonlistModel>? buttonlist,
      BlocStatus? status,
      int? type}) {
    return CommentsState(
        models: models ?? this.models,
        buttonlist: buttonlist ?? this.buttonlist,
        status: status ?? this.status,
        type: type ?? this.type);
  }

  @override
  List<Object> get props => [status, models, buttonlist, type];
}

// class CommentsInitial extends CommentsState {}

// class CommentsLoadingState extends CommentsState {}

// class CommentsLoadedState extends CommentsState {
//   // final ProdetailCommentModel model;
//   final List<CommentModel> models;
//   final List<ButtonlistModel> buttonlist;
//   final int type;

//   const CommentsLoadedState(
//       {this.models = const [], this.buttonlist = const [], this.type = 1});
//   // const CommentsLoadedState(this.model, {this.type = 1});
//   CommentsLoadedState copyWith(
//       {List<CommentModel>? models,
//       List<ButtonlistModel>? buttonlist,
//       int? type}) {
//     return CommentsLoadedState(
//         models: models ?? this.models,
//         buttonlist: buttonlist ?? this.buttonlist,
//         type: type ?? this.type);
//   }
// }

class CommentsErrorState extends CommentsState {
  final String msg;
  const CommentsErrorState(this.msg);
}
