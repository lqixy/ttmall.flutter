part of 'topic_bloc.dart';

abstract class TopicState extends Equatable {
  const TopicState();

  @override
  List<Object> get props => [];
}

class TopicInitial extends TopicState {}

class TopicLoadingState extends TopicState {}

class TopicLoadedState extends TopicState {
  final TopicModel model;
  const TopicLoadedState(this.model);
}

class TopicErrorState extends TopicState {
  final String msg;
  const TopicErrorState(this.msg);
}
