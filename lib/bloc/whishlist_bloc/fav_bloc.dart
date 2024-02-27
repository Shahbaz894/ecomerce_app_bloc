import 'package:bloc/bloc.dart';

import '../../repository/database_fav.dart';
import 'fav_event.dart';
import 'fav_state.dart';

class FavBloc extends Bloc<FavEvent, FavState> {
  final DBHelperFav dbHelperFav;

  FavBloc({required this.dbHelperFav}) : super(const FavState()) {
    // Register event handlers
    on<AddFavEvent>(_onAddFavEvent);
    on<DeleteFavEvent>(_onDeleteFavEvent);
    on<LoadTempData>(_onLoadTempData);
  }

  void _onAddFavEvent(AddFavEvent event, Emitter<FavState> emit) async {
    try {
      await dbHelperFav.insert(event.favoriteProductModel);
      final updatedFavList = await dbHelperFav.getFavoritesList();
      emit(FavState(favModel: updatedFavList));
    } catch (e) {
      // Handle error
    }
  }

  void _onDeleteFavEvent(DeleteFavEvent event, Emitter<FavState> emit) async {
    try {
      await dbHelperFav.delete(event.id);
      final updatedFavList = await dbHelperFav.getFavoritesList();
      emit(FavState(favModel: updatedFavList));
    } catch (e) {
      // Handle error
    }
  }


  void _onLoadTempData(LoadTempData event, Emitter<FavState> emit) async {
    try {
      final favoritesList = await dbHelperFav.getFavoritesList();
      emit(FavState(favModel: favoritesList));
    } catch (e) {
      // Handle error
    }
  }
}

