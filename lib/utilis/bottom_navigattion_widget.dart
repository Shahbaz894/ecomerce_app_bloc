import 'package:flutter/material.dart';
import 'package:ecomerce_app_bloc/ui/address_screen.dart';
import 'package:ecomerce_app_bloc/ui/fav_screen.dart';
import 'package:ecomerce_app_bloc/ui/home_screen.dart';
import 'package:ecomerce_app_bloc/ui/order_status.dart';

class MyBottomNavBar extends StatefulWidget {
  const MyBottomNavBar({Key? key}) : super(key: key);

  @override
  State<MyBottomNavBar> createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    FavoriteScreen(),
    AddressScreen(),
    OrderStatus(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 25,
            offset: const Offset(8, 20),
          )
        ],
        borderRadius: BorderRadius.circular(30),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BottomNavigationBar(
          selectedItemColor: Colors.redAccent,
          unselectedItemColor: Colors.black,
          currentIndex: _currentIndex,
          onTap: (index) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                if (index == 0) {
                  return const HomeScreen();
                } else if (index == 1) {
                  return FavoriteScreen();
                } else if (index == 2) { // Changed the index condition to 2
                  return AddressScreen();
                } else if (index == 3) { // Changed the index condition to 3
                  return const OrderStatus();
                }
                // Handle other cases if needed
                return Container(); // Placeholder return statement
              }),
            );

            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: "Favorite",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home_repair_service),
              label: "Address",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_shipping),
              label: "Order ",
            ),
          ],
        ),
      ),
    );
  }
}
