import 'package:bloc/bloc.dart';
import 'package:ecomerce_app_bloc/bloc/product_event.dart';
import 'package:ecomerce_app_bloc/bloc/product_state.dart';

import '../model/product_model.dart';
import '../repository/product_repository.dart';
import '../utilis/product_status.dart';

class ProductBloc extends Bloc<ProductEvent, ProductStates> {
  List<ProductModel> searchList = [];
  final ProductRepository productRepository = ProductRepository();

  ProductBloc() : super(const ProductStates()) {
    on<ProductFetched>(fetchProductApi);
    on<SearchItem>(filterList);
  }

  void fetchProductApi(ProductFetched event, Emitter<ProductStates> emit) async {
    emit(state.copyWith(
        postStatus: ProductStatus.loading)); // Emit loading state

    try {
      final products = await productRepository
          .productFetched(); // Call the repository
      emit(state.copyWith(
        postStatus: ProductStatus.success,
        message: 'success',
        postList: products,
      ));
    } catch (error, stackTrace) {
      emit(state.copyWith(
        postStatus: ProductStatus.failure,
        message: error.toString(),
      ));
    }
  }





  void filterList(SearchItem event, Emitter<ProductStates> emit) async {
    try {
      final searchQuery = event.serchQuery.toLowerCase().trim(); // Trim whitespace and convert search query to lowercase
      print('Search Query: $searchQuery'); // Debugging: Print search query to check its value
      if (searchQuery.isEmpty) {
        emit(state.copyWith(searchList: [], searchMsg: '')); // Clear search results if query is empty
      } else {
        final filteredList = state.postList.where((element) =>
            element.title!.toLowerCase().contains(searchQuery)).toList(); // Filter based on partial match of title
        print('Filtered List: $filteredList'); // Debugging: Print filtered list to check its content
        if (filteredList.isEmpty) {
          emit(state.copyWith(searchList: [], searchMsg: 'No Data Found')); // No matching results found
        } else {
          emit(state.copyWith(searchList: filteredList, searchMsg: '')); // Update search results with matching items
        }
      }
    } catch (e) {
      print('Error in filterList: $e'); // Debugging: Print any errors that occur
    }
  }





// void filterList(SearchItem event, Emitter<ProductStates> emit) async {
  //   final searchQuery = event.serchQuery.toLowerCase().trim(); // Trim whitespace and convert search query to lowercase
  //   if (searchQuery.isEmpty) {
  //     emit(state.copyWith(searchList: [], searchMsg: '')); // Clear search results if query is empty
  //   } else {
  //     final filteredList = state.postList.where((element) =>
  //         element.title!.toLowerCase().contains(searchQuery)).toList(); // Filter based on partial match of title
  //     if (filteredList.isEmpty) {
  //       emit(state.copyWith(searchList: [], searchMsg: 'No Data Found')); // No matching results found
  //     } else {
  //       emit(state.copyWith(searchList: filteredList, searchMsg: '')); // Update search results with matching items
  //     }
  //   }
  // }




// void filterList(SearchItem event, Emitter<ProductStates> emit) async {
  //   final searchQuery = event.serchQuery.toLowerCase().trim(); // Trim whitespace and convert search query to lowercase
  //   if (searchQuery.isEmpty) {
  //     emit(state.copyWith(searchList: [], searchMsg: '')); // Clear search results if query is empty
  //   } else {
  //     final filteredList = state.postList.where((element) =>
  //         element.title!.toLowerCase().contains(searchQuery)).toList(); // Filter based on partial match of title
  //     if (filteredList.isEmpty) {
  //       emit(state.copyWith(searchList: [], searchMsg: 'No Data Found')); // No matching results found
  //     } else {
  //       emit(state.copyWith(searchList: filteredList, searchMsg: '')); // Update search results with matching items
  //     }
  //   }
  // }






}