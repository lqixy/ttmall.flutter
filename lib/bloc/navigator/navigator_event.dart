part of 'navigator_bloc.dart';

abstract class NavigatorEvent extends Equatable {
  const NavigatorEvent(this.context);
  final BuildContext context;
  @override
  List<Object> get props => [context];
}

// class NavigatorToTopicEvent extends NavigatorEvent {
//   const NavigatorToTopicEvent(this.topicCode, super.context);
//   final String topicCode;
// }

class NavigatorPushEvent extends NavigatorEvent {
  const NavigatorPushEvent(
    super.context,
    this.screenWidget,
  );
  final Widget screenWidget;
}

class NavigatorPopEvent extends NavigatorEvent {
  const NavigatorPopEvent(super.context);
}

class NavigatorPopAndPushNamedEvent extends NavigatorEvent {
  const NavigatorPopAndPushNamedEvent(super.context, this.routeName);
  final String routeName;
}

class NavigatorToHomeEvent extends NavigatorEvent {
  const NavigatorToHomeEvent(super.context);
}

class NavigatorPushNamedEvent extends NavigatorEvent {
  final String routeName;
  final Object? agruments;

  const NavigatorPushNamedEvent(super.context, this.routeName,
      {this.agruments});
}
