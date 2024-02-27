import 'package:ecomerce_app_bloc/utilis/product_status.dart';
import 'package:equatable/equatable.dart';

import '../../model/address_model.dart';
import '../../utilis/addres_status.dart';

class AddressState extends Equatable{

  final AddressStatus addressStatus;
  final List<AddressModel> addModel;
  final String? message;
  const AddressState({this.addressStatus=AddressStatus.loading,this.message='',
    this.addModel= const <AddressModel>[]});

  AddressState copyWith({AddressStatus?addressStatus,List<AddressModel>?addModel,String?message}){
    return AddressState(
      addModel: addModel??this.addModel,
      addressStatus: addressStatus??this.addressStatus,
      message: message??this.message,
    );
  }




  @override
  // TODO: implement props
  List<Object?> get props =>[addressStatus,addModel,message];

}