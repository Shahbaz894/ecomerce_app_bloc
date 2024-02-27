import 'package:equatable/equatable.dart';

import '../../model/fav_,model.dart';
import '../../utilis/product_status.dart';

class FavState extends Equatable{
  final ProductStatus postStatus;
  final List<FavoriteProductModel> favModel;
  final String message;
  const FavState( {this.postStatus=ProductStatus.loading, this.message='',this.favModel=const <FavoriteProductModel>[]

});

  FavState copyWith({ProductStatus? postStatus, List<FavoriteProductModel>? favModel,String? message}){
    return FavState(
      favModel: favModel ?? this.favModel,
      postStatus:postStatus ?? this.postStatus ,
      message:message ?? this.message  ,
    );

  }


  @override
  // TODO: implement props
  List<Object?> get props => [postStatus,favModel,message];


}