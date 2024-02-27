import 'package:ecomerce_app_bloc/bloc/address_bloc/address_bloc.dart';
import 'package:ecomerce_app_bloc/bloc/address_bloc/address_event.dart';
import 'package:ecomerce_app_bloc/bloc/address_bloc/address_state.dart';
import 'package:ecomerce_app_bloc/model/address_model.dart';
import 'package:ecomerce_app_bloc/ui/widgets/round_button.dart';
import 'package:ecomerce_app_bloc/utilis/product_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../utilis/addres_status.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  TextEditingController addressController=TextEditingController();
  TextEditingController phoneNoController=TextEditingController();
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AddressBloc>(context).add(LoadAddress());
  }

  @override
  Widget build(BuildContext context) {

    //return
      // BlocBuilder<AddressBloc,AddressState>(builder: (context,state) {
      // if(state.addressStatus==AddressStatus.loading){
      //   return const Center(child: CircularProgressIndicator(color: Colors.red,),);
      // }else if(state.addressStatus==AddressStatus.failure){
      //   return Center(child: Text(state.message.toString()));
      //
      // }else{
        return  Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: const Center(child: Text('Delivery Address')),
          ),
          body:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                keyboardType: TextInputType.text,
                controller: addressController,

                decoration: InputDecoration(
                  border: OutlineInputBorder( // Border style
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder( // Border style when the field is focused
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.blue),
                  ),


                  enabledBorder: OutlineInputBorder( // Border style when the field is not focused
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  //errorText: 'Invalid username', // Error message text
                  hintText: 'Address',
                  helperText: 'enter your address',
                  prefixIcon: const Icon(Icons.home),


                ),

                validator:(value){
                  if(value!.isEmpty){
                    return 'Enter your address';
                  }
                  return null;


                } ,
              ),
              const SizedBox(height: 20,),
              TextFormField(

                controller: phoneNoController,

                decoration: InputDecoration(
                  border: OutlineInputBorder( // Border style
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder( // Border style when the field is focused
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.blue),
                  ),


                  enabledBorder: OutlineInputBorder( // Border style when the field is not focused
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  //errorText: 'Invalid username', // Error message text
                  hintText: '+92 332 7891122',
                  helperText: 'enter your Mobile No',
                  prefixIcon: const Icon(Icons.phone),


                ),

                validator:(value){
                  if(value!.isEmpty){
                    return 'Enter your Mobile';
                  }
                  return null;


                } ,
              ),
              const SizedBox(height: 20,),
              RoundButton(title: 'Save Address', onTap: (){

               try{
                 BlocProvider.of<AddressBloc>(context).add(
                     AddAddress(AddressModel(

                       address: addressController.text,

                        mobile: phoneNoController.text,

                     )));
                 ScaffoldMessenger.of(context).showSnackBar(
                   const SnackBar(
                     content: Text('Address Saved Successfully',
                       style: TextStyle(color: Colors.white),
                     ),
                     backgroundColor: Colors.green, // Background color of the SnackBar
                     duration: Duration(seconds: 5), // Duration for which SnackBar is displayed
                   ),
                 );
               }catch(e){
                 ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                     content: Text(
                       e.toString(),
                       style: TextStyle(color: Colors.white),
                     ),
                     backgroundColor: Colors.green, // Background color of the SnackBar
                     duration: Duration(seconds: 5), // Duration for which SnackBar is displayed
                   ),
                 );
               }

              }),
             //s Text(context.read<AddressBloc>().dbHelperAddress.getAddress()),


            ],
          ),
        );
      //}
    //});
  }
}
















