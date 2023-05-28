part of 'address_bloc.dart';

abstract class AddressState extends Equatable {
  const AddressState();

  @override
  List<Object> get props => [];
}

class AddressInitial extends AddressState {}

class AddressLoadingState extends AddressState {}

class AddressLoadedState extends AddressState {
  final List<AddressModel> list;
  final PickAddressModel pickAddressModel;
  const AddressLoadedState(this.list, this.pickAddressModel);
}

class AddressErrorState extends AddressState {
  final String msg;
  const AddressErrorState(this.msg);
}

class AddressSetDefaultSuccessState extends AddressState {}

class AddressSetDefaultErrorState extends AddressState {
  final String msg;
  const AddressSetDefaultErrorState(this.msg);
}
