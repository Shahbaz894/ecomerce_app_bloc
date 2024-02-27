//
//
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
//
// import '../../bloc/product_bloc.dart';
// import '../../bloc/product_event.dart';
// import '../../bloc/product_state.dart';
// import '../../utilis/product_status.dart';
// import '../product_detail_screen.dart';
//
// class SearchScreen extends StatelessWidget {
//   final String? searchQuery;
//
//   const SearchScreen({Key? key, this.searchQuery}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ProductBloc, ProductStates>(
//       builder: (context, state) {
//         if (state.postStatus == ProductStatus.loading) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (state.postStatus == ProductStatus.failure) {
//           return Center(child: Text(state.message));
//         } else {
//           return SafeArea(
//             child: Scaffold(
//               body: Column(
//                 children: [
//                   Stack(
//                     children: [
//                       ClipPath(
//                         clipper: WaveClipperTwo(reverse: false),
//                         child: Container(
//                           height: 100,
//                           width: double.infinity,
//                           color: Colors.green,
//                         ),
//                       ),
//                       Positioned(
//                         top: 20,
//                         child: IconButton(
//                           icon: Icon(Icons.arrow_back_ios),
//                           color: Colors.white,
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                         ),
//                       )
//                     ],
//                   ),
//                   SizedBox(height: 10),
//                   Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(25),
//                         color: Colors.grey[200],
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.5),
//                             spreadRadius: 3,
//                             blurRadius: 7,
//                             offset: Offset(0, 3),
//                           ),
//                         ],
//                       ),
//                       child: TextFormField(
//                         style: const TextStyle(color: Colors.black87),
//                         cursorColor: Colors.black87,
//                         onChanged: (query) {
//                           context.read<ProductBloc>().add(SearchItem(query));
//                         },
//                         decoration: InputDecoration(
//                           labelText: 'Search Product',
//                           hintText: 'Enter product name...',
//                           prefixIcon: Icon(Icons.search, color: Colors.black87),
//                           border: InputBorder.none,
//                           contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.transparent),
//                             borderRadius: BorderRadius.circular(25),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.black87),
//                             borderRadius: BorderRadius.circular(25),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: state.searchMsg.isNotEmpty
//                         ? Center(child: Text(state.searchMsg.toString()))
//                         : ListView.builder(
//                       itemCount: state.searchList.isNotEmpty
//                           ? state.searchList.length
//                           : state.postList.length,
//                       itemBuilder: (context, index) {
//                         final item = state.searchList.isNotEmpty
//                             ? state.searchList[index]
//                             : state.postList[index];
//                         return GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => ProductDetailScreen(
//                                   title: item.title,
//                                   productImage: item.image,
//                                   productPrice: item.price,
//                                   productId: item.id,
//                                   productDescription: item.description,
//                                 ),
//                               ),
//                             );
//                           },
//                           child: Card(
//                             child: ListTile(
//                               title: Text(item.title.toString()),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }
//       },
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import '../../bloc/product_bloc.dart';
import '../../bloc/product_event.dart';
import '../../bloc/product_state.dart';
import '../../utilis/product_status.dart';
import '../product_detail_screen.dart';

class SearchScreen extends StatelessWidget {
  final String? searchQuery;

  const SearchScreen({Key? key, this.searchQuery}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductStates>(
      builder: (context, state) {
        if (state.postStatus == ProductStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.postStatus == ProductStatus.failure) {
          return Center(child: Text(state.message));
        } else {
          return SafeArea(
            child: Scaffold(
              body: Column(
                children: [
                  Stack(
                    children: [
                      ClipPath(
                        clipper: WaveClipperTwo(reverse: false),
                        child: Container(
                          height: 100,
                          width: double.infinity,
                          color: Colors.green,
                        ),
                      ),
                      Positioned(
                        top: 20,
                        child: IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          color: Colors.white,
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            Navigator.pop(context);
                          },
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.grey[200],
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.black87),
                        cursorColor: Colors.black87,
                        onChanged: (query) {
                          context.read<ProductBloc>().add(SearchItem(query));
                        },
                        decoration: InputDecoration(
                          labelText: 'Search Product',
                          hintText: 'Enter product name...',
                          prefixIcon: Icon(Icons.search, color: Colors.black87),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black87),
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: state.searchMsg.isNotEmpty
                        ? Center(child: Text(state.searchMsg.toString()))
                        : state.searchList.isNotEmpty
                        ? ListView.builder(
                      itemCount: state.searchList.length,
                      itemBuilder: (context, index) {
                        final item = state.searchList[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailScreen(
                                  title: item.title,
                                  productImage: item.image,
                                  productPrice: item.price,
                                  productId: item.id,
                                  productDescription: item.description,
                                ),
                              ),
                            );
                          },
                          child: Card(
                            child: ListTile(
                              title: Text(item.title.toString()),
                            ),
                          ),
                        );
                      },
                    )
                        : SizedBox(), // If searchList is empty, show an empty SizedBox
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
