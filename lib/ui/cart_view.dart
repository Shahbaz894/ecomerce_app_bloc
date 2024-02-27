import 'dart:developer';
import 'package:ecomerce_app_bloc/repository/address_database.dart';
import 'package:ecomerce_app_bloc/ui/address_screen.dart';
import 'package:ecomerce_app_bloc/utilis/addres_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';

import '../bloc/address_bloc/address_bloc.dart';
import '../bloc/address_bloc/address_state.dart';
import 'component/cart_title_widget.dart';
import 'component/empty_cart_msg.dart';
import 'order_status.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  DBHelperAddress dbHelperAddress=DBHelperAddress();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('My Cart')),
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Expanded(
                child: PersistentShoppingCart().showCartItems(
                  cartTileWidget: ({required data}) => CartTileWidget(data: data),
                  showEmptyCartMsgWidget: const EmptyCartMsgWidget(),
                ),
              ),
              PersistentShoppingCart().showTotalAmountWidget(
                cartTotalAmountWidgetBuilder: (totalAmount) {
                  log('Total Amount: $totalAmount');
                  return Visibility(
                    visible: totalAmount != 0.0, // Show only if totalAmount is not zero
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
                            final shoppingCart = PersistentShoppingCart();
                            // Retrieve cart data and total price
                            Map<String, dynamic> cartData = shoppingCart.getCartData();
                            // Extract cart items and total price
                            List<PersistentShoppingCartItem> cartItems = cartData['cartItems'];
                            double totalPrice = cartData['totalPrice'];
                            /* since cart items is a list, you can run a loop to extract all the values
                               send it to api or firebase based on your requirement */
                            log('Total Price: $totalPrice');
                           Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderStatus()));




                          },
                          child: const Text('Checkout'),
                        ),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
