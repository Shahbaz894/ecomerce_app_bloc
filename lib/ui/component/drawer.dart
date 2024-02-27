import 'package:ecomerce_app_bloc/ui/address_screen.dart';
import 'package:ecomerce_app_bloc/ui/payment_screen.dart';
import 'package:flutter/material.dart';

import '../../auth_services1/login_screen.dart';
import '../fav_screen.dart';
import '../order_status.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  // You can add your user profile image here
                  // backgroundImage: NetworkImage('https://example.com/your_image.jpg'),
                ),
                SizedBox(height: 10),
                Text(
                  'Shahbaz Zulfiqar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),

              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              // Navigate to the home screen
              Navigator.pop(context); // Close the drawer
              // Add your navigation logic here
            },
          ),
          ListTile(
            leading: Icon(Icons.location_city_sharp),
            title: const Text('Address'),
            onTap: () {
              // Navigate to the home screen
              Navigator.pop(context); // Close the drawer
              Navigator.push(context, MaterialPageRoute(builder: (context)=>AddressScreen()));// Close the drawer
              // Add your logout logic here
            },
          ),
          ListTile(
            leading: Icon(Icons.monetization_on),
            title: const Text('Payment'),
            onTap: () {
              // Navigate to the home screen
              Navigator.pop(context); // Close the drawer
              // Add your navigation logic here
              Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentScreen()));// Close the drawer
              // Add your logout logic here
            },
          ),
          ListTile(
            leading: const Icon(Icons.local_shipping),
            title: const Text('Order Status'),
            onTap: () {
              // Navigate to the home screen
              Navigator.pop(context); // Close the drawer
              // Add your navigation logic here
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const OrderStatus()));// Close the drawer
              // Add your logout logic here
            },
          ),


          Divider(),
          ListTile(
            leading: Icon(Icons.notification_add),
            title: Text('Notification'),
            onTap: () {
              // Implement your logout logic
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>FavoriteScreen()));// Close the drawer
              // Add your logout logic here
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              // Implement your logout logic
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));// Close the drawer
              // Add your logout logic here
            },
          ),
        ],
      ),
    );
  }
}
