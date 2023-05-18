part of 'navigator_bloc.dart';

abstract class NavigatorEvent extends Equatable {
  const NavigatorEvent(this.context);
  final BuildContext context;
  @override
  List<Object> get props => [context];
}

class NavigatorToTopicEvent extends NavigatorEvent {
  const NavigatorToTopicEvent(this.topicCode, super.context);
  final String topicCode;
}
