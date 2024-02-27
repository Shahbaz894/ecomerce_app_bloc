import 'package:ecomerce_app_bloc/ui/address_screen.dart';
import 'package:ecomerce_app_bloc/ui/carsol_slider_screen.dart';
import 'package:ecomerce_app_bloc/ui/product_grid_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';

import '../utilis/bottom_navigattion_widget.dart';
import 'cart_view.dart';
import 'component/drawer.dart';
import 'component/search_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return   SafeArea(
      child: Scaffold(
   
        appBar: AppBar(
          title: const Text(
            'Home',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchScreen()),
                );


              },
              icon: const Icon(Icons.search),
            ),
            PersistentShoppingCart().showCartItemCountWidget(
              cartItemCountWidgetBuilder: (itemCount) => IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartView()),
                  );
                },
                icon: Badge(
                  label: Text(itemCount.toString()),
                  child: const Icon(Icons.shopping_bag_outlined),
                ),
              ),
            ),
            const SizedBox(width: 20.0)
          ],
        ),

        drawer: AppDrawer(),
        body:

          const Column(
          children: [
            Expanded(child: Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: CarousalSliderScreen(),
            )),
             Padding(
               padding: EdgeInsets.only(right: 150.0),
               child: Text('Recommend Product',style: TextStyle(color: Colors.red,fontSize: 20,fontWeight: FontWeight.bold),),
             ),
             Expanded(child: ProductGridViewScreen()),
            MyBottomNavBar()




          ],
        ),
      ),
    );
  }
}








