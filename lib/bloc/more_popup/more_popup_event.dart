part of 'more_popup_bloc.dart';

abstract class MorePopupEvent extends Equatable {
  const MorePopupEvent();

  @override
  List<Object> get props => [];
}

class MorePopupNavtoEvent extends MorePopupEvent {
  final BuildContext context;
  final MorePopupType type;

  const MorePopupNavtoEvent(this.context, this.type);
}

enum MorePopupType { indexPage, category, cart, profile }
