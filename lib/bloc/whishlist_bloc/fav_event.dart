
import 'package:ecomerce_app_bloc/model/fav_,model.dart';
import 'package:equatable/equatable.dart';

abstract class FavEvent extends Equatable {
  const FavEvent();

  @override
  List<Object?> get props => [];
}

class LoadTempData extends FavEvent {}

class AddFavEvent extends FavEvent {
  final FavoriteProductModel favoriteProductModel;

  const AddFavEvent(this.favoriteProductModel);

  @override
  List<Object?> get props => [favoriteProductModel];


}

class DeleteFavEvent extends FavEvent {
  final int id;

  //const DeleteTempEvent(this.id, {required id});
  const DeleteFavEvent({required this.id, });

  @override
  List<Object?> get props => [id];
}