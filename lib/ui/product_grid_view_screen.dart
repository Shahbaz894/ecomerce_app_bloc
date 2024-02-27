
import 'package:ecomerce_app_bloc/bloc/whishlist_bloc/fav_event.dart';
import 'package:ecomerce_app_bloc/model/fav_,model.dart';
import 'package:ecomerce_app_bloc/repository/database_fav.dart';
import 'package:ecomerce_app_bloc/ui/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';
import '../bloc/whishlist_bloc/fav_bloc.dart';
import '../utilis/product_status.dart';


class ProductGridViewScreen extends StatefulWidget {
  const ProductGridViewScreen({Key? key});

  @override
  State<ProductGridViewScreen> createState() => _ProductGridViewScreenState();
}

class _ProductGridViewScreenState extends State<ProductGridViewScreen> {
  final DBHelperFav dbHelperFav = DBHelperFav();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProductBloc>(context).add(ProductFetched());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductStates>(
      builder: (context, state) {
        if (state.postStatus == ProductStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.postStatus == ProductStatus.failure) {
          return Center(child: Text(state.message));
        } else {
          return Scaffold(


            body: OrientationBuilder(
              builder: (context, orientation) {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: (orientation == Orientation.landscape) ? 2 : 3,
                    childAspectRatio: 4 / 4.2,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                  ),
                  itemCount: state.postList.length,
                  itemBuilder: (context, index) {
                    final product = state.postList[index];
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => ProductDetailScreen(
                                        productId: product.id,
                                        title: product.title.toString(),
                                        productImage: product.image.toString(),
                                        productPrice: product.price,
                                        productDescription: product.description.toString(),
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 140,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(15.0),
                                      topRight: Radius.circular(15.0),
                                    ),
                                    image: DecorationImage(
                                      image: NetworkImage(product.image.toString()),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 0, left: 160),
                                child: IconButton(
                                  onPressed: () {
                                    BlocProvider.of<FavBloc>(context).add(AddFavEvent(
                                      FavoriteProductModel(
                                        id: product.id,
                                        title: product.title.toString().substring(0, 18),
                                        price: product.price,
                                        image: product.image,
                                      ),
                                    ));
                                  },
                                  icon: const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 138.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.title.toString().substring(0, 18),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Text(
                                          "\$${product.price.toString()}",
                                          style: const TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                        SizedBox(width: (orientation == Orientation.portrait) ? 50 : 20),
                                        Expanded(
                                          child: Ink(
                                            decoration: ShapeDecoration(
                                              color: Colors.green[700],
                                              shape: const CircleBorder(),
                                            ),
                                            child: IconButton(
                                              onPressed: () {
                                                PersistentShoppingCart().addToCart(
                                                  PersistentShoppingCartItem(
                                                    productId: product.id.toString(),
                                                    productName: product.title.toString(),
                                                    unitPrice: double.parse(product.price.toString()),
                                                    productDescription: product.description.toString(),
                                                    productThumbnail: product.image.toString(),
                                                    quantity: 1, // You can set the initial quantity to 1
                                                  ),
                                                );
                                              },
                                              icon: const Icon(Icons.add_shopping_cart),
                                              color: Colors.white,
                                              splashRadius: 15,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          );
        }
      },
    );
  }
}
