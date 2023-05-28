part of 'address_bloc.dart';

abstract class AddressEvent extends Equatable {
  const AddressEvent();

  @override
  List<Object> get props => [];
}

class AddressLoadEvent extends AddressEvent {}

class AddressSetDefaultEvent extends AddressEvent {
  final String addressId;
  const AddressSetDefaultEvent(this.addressId);
}
