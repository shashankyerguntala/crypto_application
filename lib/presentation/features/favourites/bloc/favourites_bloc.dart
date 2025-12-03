import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_l3/core/constants/string_constants.dart';
import 'package:final_l3/data/models/crypto_model.dart';
import 'package:final_l3/domain/usecase/hive_usecase.dart';

part 'favourites_event.dart';
part 'favourites_state.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  final HiveUseCase hiveUseCase;

  FavouritesBloc(this.hiveUseCase) : super(FavouritesInitial()) {
    on<LoadFavouritesEvent>(loadFavourites);
    on<AddFavouriteEvent>(addFavourite);
    on<RemoveFavouriteEvent>(removeFavourite);
  }

  Future<void> loadFavourites(
    LoadFavouritesEvent event,
    Emitter<FavouritesState> emit,
  ) async {
    emit(FavouritesLoading());
    try {
      final list = hiveUseCase.getFavourites();
      emit(FavouritesLoaded(list));
    } catch (e) {
      emit(FavouritesError(StringConstants.failedToLoadFav));
    }
  }

  Future<void> addFavourite(
    AddFavouriteEvent event,
    Emitter<FavouritesState> emit,
  ) async {
    try {
      final list = hiveUseCase.getFavourites();

      final exists = list.any((c) => c.id == event.coin.id);
      if (!exists) {
        list.add(event.coin);
        await hiveUseCase.saveFavourites(list);
      }

      emit(FavouritesLoaded(List.from(list)));
    } catch (e) {
      emit(FavouritesError(StringConstants.failedToAdd));
    }
  }

  Future<void> removeFavourite(
    RemoveFavouriteEvent event,
    Emitter<FavouritesState> emit,
  ) async {
    try {
      final list = hiveUseCase.getFavourites();

      list.removeWhere((c) => c.id == event.coinId);

      await hiveUseCase.saveFavourites(list);

      emit(FavouritesLoaded(List.from(list)));
    } catch (e) {
      emit(FavouritesError(StringConstants.failedToRemoveFav));
    }
  }
}
