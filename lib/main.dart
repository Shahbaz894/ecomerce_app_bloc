
import 'package:ecomerce_app_bloc/bloc/address_bloc/address_bloc.dart';
import 'package:ecomerce_app_bloc/bloc/product_bloc.dart';
import 'package:ecomerce_app_bloc/bloc/whishlist_bloc/fav_bloc.dart';
import 'package:ecomerce_app_bloc/bloc/whishlist_bloc/fav_state.dart';
import 'package:ecomerce_app_bloc/repository/address_database.dart';
import 'package:ecomerce_app_bloc/repository/database_fav.dart';
import 'package:ecomerce_app_bloc/ui/carsol_slider_screen.dart';
import 'package:ecomerce_app_bloc/ui/home_screen.dart';
import 'package:ecomerce_app_bloc/ui/product_grid_view_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await PersistentShoppingCart().init();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyB8F-NAgR4mlKr8UMvz796AODr17tLLyU4",
      appId: "1:312258948396:android:a2e5c0d6b575d407ed9089 ",

      projectId: "ecommerce-app-bloc",
      messagingSenderId: '76628789109',
      databaseURL: "https://ecommerce-app-bloc-default-rtdb.firebaseio.com",

    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
      MultiBlocProvider(
        providers: [

          BlocProvider<ProductBloc>(
            create: (_) => ProductBloc(),


          ),
          BlocProvider<AddressBloc>(
            create: (context) => AddressBloc(dbHelperAddress: DBHelperAddress()),


          ),
          BlocProvider<FavBloc>(
          create: (context) => FavBloc(dbHelperFav: DBHelperFav()),
          )

        ],
        child: MaterialApp(
          theme: ThemeData.light(),
          home:  const HomeScreen(),
        ),
      );


  }
}

