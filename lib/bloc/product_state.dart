
import 'package:equatable/equatable.dart';

import '../model/product_model.dart';
import '../utilis/product_status.dart';



class ProductStates extends Equatable{
  final ProductStatus postStatus;
  final List<ProductModel> postList;
  final List<ProductModel> searchList;
  final String message;
  final String searchMsg;
  const ProductStates ( {
    this.searchList=const <ProductModel>[],
    this.postStatus=ProductStatus.loading,
    this.postList=const <ProductModel>[],
    this.message='',
    this.searchMsg=''

  });
  ProductStates copyWith({ProductStatus? postStatus,
    List<ProductModel>? postList,
    String? message,
    String?searchMsg,
    List<ProductModel>? searchList

  }){
    return  ProductStates(
      postList: postList ?? this.postList,
      postStatus:postStatus ?? this.postStatus ,
      message:message ?? this.message  ,
      searchList:searchList?? this.searchList,
      searchMsg: searchMsg??this.searchMsg


    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [postStatus,postList,message,searchList,searchMsg];

}