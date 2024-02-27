import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';

import '../bloc/product_bloc.dart';
import '../bloc/product_state.dart';
import '../utilis/product_status.dart';
import 'cart_view.dart';

class ProductDetailScreen extends StatefulWidget {
  final String? title;
  final num? productPrice;
  final String? productImage;
  final String? productDescription;
  final int? productId;

  const ProductDetailScreen({
    required this.title,
    required this.productImage,
    required this.productPrice,
    this.productDescription,
    Key? key, this.productId,
  }) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductStates>(
      builder: (context, state) {
        if (state.postStatus == ProductStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.red),
          );
        } else if (state.postStatus == ProductStatus.failure) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Product Detail',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              backgroundColor: Colors.green,
              actions: [
                IconButton(
                  onPressed: () {},
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
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: Colors.grey,
                          width: 2.0,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Image.network(
                            widget.productImage ?? '',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                          Positioned(
                            top: 8,
                            right: 1,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.green,
                              ),
                              child: Center(
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.favorite, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      widget.title ?? '',
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Price: \$${widget.productPrice.toString()}' ?? '',
                      style: const TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Product Description:',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.productDescription ?? '',
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              child: SizedBox(
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      PersistentShoppingCart().addToCart(
                        PersistentShoppingCartItem(
                          productId: widget.productId.toString(),
                          productName: widget.title.toString(),
                          unitPrice: double.parse(widget.productPrice.toString()),
                          productDescription: widget.productDescription.toString(),
                          productThumbnail: widget.productImage.toString(),
                          quantity: 1, // You can set the initial quantity to 1
                        ),
                      );
                      // Add to cart functionality
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                    child: const Text(
                      'Add to Cart',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
