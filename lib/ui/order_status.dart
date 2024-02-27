
import 'package:ecomerce_app_bloc/ui/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Import Bloc library
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';
import '../bloc/address_bloc/address_bloc.dart';
import '../bloc/address_bloc/address_event.dart';
import '../bloc/address_bloc/address_state.dart';
import 'address_screen.dart';
import 'component/empty_cart_msg.dart';

class OrderStatus extends StatefulWidget {
  const OrderStatus({Key? key}) : super(key: key);

  @override
  State<OrderStatus> createState() => _OrderStatusState();
}

class _OrderStatusState extends State<OrderStatus> {
  @override
  void initState() {
    super.initState();
    // Fetch data automatically from the database when the widget is initialized
    fetchDataFromDatabase();
  }

  void fetchDataFromDatabase() {
    // Implement logic to fetch data from the database
    // Example:
    // You can call your repository, database helper, or network service here
    // and handle the asynchronous data fetching process.
    // Once data is fetched, you can update the state using setState or
    // by dispatching appropriate events to your Bloc or provider.
    // // For example:
    //  BlocProvider.of<AddressBloc>(context).add(());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Center(child: Text('Order Status')),
      ),
      body: Column(
        children: <Widget>[
          BlocBuilder<AddressBloc, AddressState>(
            builder: (context, state) {
              if (state.addModel.isEmpty) {
                return Center(
                  child: Text(
                    'Your Address list is empty 😌',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                );
              } else {
                return
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2, // Set height to half of the screen height
                    width: double.infinity, // Set width to occupy all available horizontal space

                    child:
                    ListView.builder(
                    itemCount: state.addModel.length,
                    itemBuilder: (context, index) {
                      final address = state.addModel[index]; // Access individual address using index
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Card(
                          elevation: 3, // Add elevation for a material-like effect
                          child: ListTile(
                            title: Text(
                              address.address.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(address.mobile.toString()),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min, // Ensure the row takes minimum space
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    // Add logic to edit the address
                                    final id = address.id ?? 0; // Use a default value if address.id is null
                                    BlocProvider.of<AddressBloc>(context).add(UpdateAddress(id: id));
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddressScreen()));
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    // Add logic to delete the address
                                    final id = address.id ?? 0; // Use a default value if address.id is null
                                    BlocProvider.of<AddressBloc>(context).add(DeleteAddress(id: id));
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                                      ),
                  );
              }
            },
          ),
          Expanded(
            child: PersistentShoppingCart().showCartItems(
              cartTileWidget: ({required data}) {
                String productName = data.productName;
                double price = data.unitPrice;
                return ListTile(
                  title: Text(productName.toString().substring(0, 18)),
                  subtitle: Text('Price: \$${price.toStringAsFixed(2)}'),
                );
              },
              showEmptyCartMsgWidget: const EmptyCartMsgWidget(),
            ),
          ),
          PersistentShoppingCart().showTotalAmountWidget(
            cartTotalAmountWidgetBuilder: (totalAmount) {
              return Visibility(
                visible: totalAmount != 0.0,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total', style: TextStyle(color: Colors.white, fontSize: 22)),
                        Text(r'$' + totalAmount.toString(), style: const TextStyle(color: Colors.black, fontSize: 22)),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentScreen()));
                      },
                      child: const Text('Place Order'),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
