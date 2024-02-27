

import 'package:ecomerce_app_bloc/bloc/address_bloc/address_event.dart';
import 'package:ecomerce_app_bloc/bloc/address_bloc/address_state.dart';
import 'package:ecomerce_app_bloc/repository/address_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/address_model.dart';
import '../../utilis/addres_status.dart';
import '../../utilis/product_status.dart';

class AddressBloc extends Bloc<AddressEvent,AddressState>{
  final DBHelperAddress dbHelperAddress;
  AddressBloc({required this.dbHelperAddress}) :super (const AddressState()){
    on<AddAddress> (_addAddressDatabase);
    on<UpdateAddress>(_updateAddressDatabase);
    on<GetAddress>(getAddressDatabase);
    on<DeleteAddress>(_onDeleteAddress);
    on<LoadAddress>(_onLoadAddress);
  }


  void _onLoadAddress(LoadAddress event, Emitter<AddressState> emit) async {
    try {
      final favoritesList = await dbHelperAddress.getAddress();
      emit(AddressState(addModel: favoritesList));
    } catch (e) {
      // Handle error
    }
  }

  void _addAddressDatabase(AddAddress event, Emitter<AddressState> emit) async {
    try {
      emit(state.copyWith(addressStatus: AddressStatus.loading)); // Emit loading state

      await dbHelperAddress.insert(event.addressModel);
      final addAddressDatabase = await dbHelperAddress.getAddress();
      emit(AddressState(addModel: addAddressDatabase));
    } catch (e) {
      print("Error inserting address: $e");
      emit(state.copyWith(addressStatus: AddressStatus.failure, message: e.toString())); // Emit failure state
    }
  }




  void _updateAddressDatabase(UpdateAddress event, Emitter<AddressState> emit) async {
    try {
      emit(state.copyWith(addressStatus: AddressStatus.loading)); // Emit loading state

      // Check if the event's ID is not null
      if (event.id != null) {
        // Create an AddressModel with the provided ID and any updated fields
        AddressModel addressToUpdate = AddressModel(
          id: event.id,
          // Include any updated fields here
        );

        // Update the address in the database
        await dbHelperAddress.updateAddress(addressToUpdate);

        // Retrieve the updated address from the database
        final updatedAddress = await dbHelperAddress.getAddress();

        // Emit the updated address state
        emit(AddressState(addModel: updatedAddress));
      } else {
        // Handle the case where the event's ID is null
        // You might want to throw an exception, log an error, or emit a failure state
        throw Exception("ID is null. Unable to update address.");
      }
    } catch (e) {
      print("Error updating address: $e");
      // If an error occurs during the update, emit a failure state
      emit(state.copyWith(addressStatus: AddressStatus.failure, message: e.toString()));
    }
  }




  void getAddressDatabase(GetAddress event, Emitter<AddressState> emit) async {
    try {
      emit(state.copyWith(addressStatus: AddressStatus.loading)); // Emit loading state

      // Assuming dbHelperAddress is an instance of your DatabaseHelper class
      List<AddressModel> addresses = await dbHelperAddress.getAddress();

      emit(state.copyWith(addressStatus: AddressStatus.success, addModel: addresses)); // Emit success state with loaded addresses
    } catch (e) {
      print("Error fetching addresses: $e");
      emit(state.copyWith(addressStatus: AddressStatus.failure, message: e.toString())); // Emit failure state
    }
  }


  void _onDeleteAddress(DeleteAddress event, Emitter<AddressState> emit) async {
    try {
      await dbHelperAddress.delete(event.id);
      final updatedAddressList = await dbHelperAddress.getAddress();
      emit(AddressState(addModel: updatedAddressList));
    } catch (e) {
      // Handle error
    }
  }



}