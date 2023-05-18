part of 'topic_bloc.dart';

abstract class TopicEvent extends Equatable {
  const TopicEvent();

  @override
  List<Object> get props => [];
}

class TopicLoadEvent extends TopicEvent {
  final String topicCode;
  const TopicLoadEvent(this.topicCode);
}

// class TopicJumpToEvent extends TopicEvent {
//   final BuildContext context;
//   final String goodsId;
//   const TopicJumpToEvent(this.context, this.goodsId);
// }
