import 'package:ecomerce_app_bloc/model/address_model.dart';
import 'package:equatable/equatable.dart';

abstract class AddressEvent extends Equatable{

  @override
  List<Object?> get props => [];
}
class LoadAddress extends AddressEvent{}

class AddAddress extends AddressEvent{
  final AddressModel addressModel;
  AddAddress(this.addressModel);
  List<Object?> get props => [addressModel];
}


class UpdateAddress extends AddressEvent{
  final int id;
  UpdateAddress({required this.id});
  List<Object?> get props => [id];
}
class GetAddress extends AddressEvent{
  final int id;
  GetAddress({required this.id});
  List<Object?> get props => [id];
}
class DeleteAddress extends AddressEvent{
  final int id;
  DeleteAddress({required this.id});
  List<Object?> get props => [id];
}