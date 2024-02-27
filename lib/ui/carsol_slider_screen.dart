import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecomerce_app_bloc/bloc/product_state.dart';
import 'package:ecomerce_app_bloc/ui/product_detail_screen.dart';
import 'package:ecomerce_app_bloc/utilis/product_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../model/fav_,model.dart';
import '../model/product_model.dart';

import '../repository/database_fav.dart';
//
// class CarousalSliderScreen extends StatefulWidget {
//   const CarousalSliderScreen({super.key});
//
//   @override
//   State<CarousalSliderScreen> createState() => _CarousalSliderScreenState();
//
// }
//
// class _CarousalSliderScreenState extends State<CarousalSliderScreen> {
//   DBHelperFav dbHelperFav=DBHelperFav();
//   int currentIndex = 0;
//
//
//   @override
//   void initState() {
//     super.initState();
//     BlocProvider.of<ProductBloc>(context).add(ProductFetched());
//   }
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ProductBloc,ProductStates>(builder: (context, state){
//       if(state.postStatus==ProductStatus.loading){
//         return Center(child: CircularProgressIndicator(color: Colors.red,),);
//
//       }else if(state.postStatus==ProductStatus.failure){
//         return Center(child: Text(state.message),);
//       }else{
//         return Scaffold(
//           body:CarouselSlider.builder(
//               itemCount: state.postList.length,
//               itemBuilder: (BuildContext context,int index,int realIndex){
//                 final product = state.postList[index];
//                 return SafeArea(
//                   child: GestureDetector(
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Container(
//                         height: 450,
//                         width: 400,
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.black),
//                           borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
//                         ),
//
//
//                         child: Stack(children: [
//                           ClipRRect(
//                             borderRadius: const BorderRadius.only(
//                               topLeft: Radius.circular(15),
//                               topRight: Radius.circular(15)
//                             ),
//                             child: Image.network(
//                               product.image.toString(),
//                               width: 300,
//                               height: 150,
//                               fit: BoxFit.fill,
//
//                             ),
//
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(top: 108.0),
//                             child: Row(children: [
//                               Text(product.price.toString(),style: TextStyle(color: Colors.green,fontSize: 15,fontWeight: FontWeight.bold),),
//                               Spacer(),
//                               Text(product.title.toString().substring(0,18),style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),),
//                             ],),
//                           )
//
//                         ],),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//               options: CarouselOptions(
//                 height: 180.0,
//                 enlargeCenterPage: true,
//                 autoPlay: true,
//                 aspectRatio: 16 / 9,
//                 autoPlayCurve: Curves.fastOutSlowIn,
//                 enableInfiniteScroll: true,
//                 autoPlayAnimationDuration: const Duration(milliseconds: 800),
//                 viewportFraction: 0.8,
//               ))
//
//
//         );
//       }
//     });
//   }
// }
class CarousalSliderScreen extends StatefulWidget {
  const CarousalSliderScreen({Key? key}) : super(key: key);

  @override
  State<CarousalSliderScreen> createState() => _CarousalSliderScreenState();
}

class _CarousalSliderScreenState extends State<CarousalSliderScreen> {
  int currentIndex = 0;

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
          return const Center(
            child: CircularProgressIndicator(color: Colors.red),
          );
        } else if (state.postStatus == ProductStatus.failure) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return Scaffold(
            body: CarouselSlider.builder(
              itemCount: state.postList.length,
              itemBuilder: (BuildContext context, int index, int realIndex) {
                final product = state.postList[index];
                return GestureDetector(
                  onTap: () {
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child:
                    Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width*1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
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
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  product.image.toString(),
                                  width: MediaQuery.of(context).size.width,
                                  height: 150,
                                  fit: BoxFit.fill,
                                ),
                              ),



                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                height: 190, // Adjust the height of the CarouselSlider
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                viewportFraction: 0.6,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
            ),
          );
        }
      },
    );
  }
}



