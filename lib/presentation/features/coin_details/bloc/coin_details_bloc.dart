import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_l3/core/constants/string_constants.dart';
import 'package:final_l3/data/models/crypto_model.dart';
import 'package:final_l3/domain/usecase/hive_usecase.dart';

part 'coin_details_event.dart';
part 'coin_details_state.dart';

class CoinDetailsBloc extends Bloc<CoinDetailsEvent, CoinDetailsState> {
  final HiveUseCase hiveUseCase;

  CoinDetailsBloc(this.hiveUseCase) : super(CoinDetailsInitial()) {
    on<AddToFavouritesEvent>(addToFavourites);
  }

  Future<void> addToFavourites(
    AddToFavouritesEvent event,
    Emitter<CoinDetailsState> emit,
  ) async {
    emit(FavouriteAddLoading());

    try {
      final email = hiveUseCase.getCurrentUser();
      if (email == null) {
        emit(FavouriteAddError(StringConstants.userNotLoggedIn));
        return;
      }

      final favs = hiveUseCase.getFavourites(email);

      final exists = favs.any((c) => c.id == event.coin.id);
      if (exists) {
        emit(FavouriteAddError(StringConstants.alreadyFav));
        return;
      }

      favs.add(event.coin);

      await hiveUseCase.saveFavourites(email, favs);

      emit(FavouriteAddSuccess());
    } catch (e) {
      emit(FavouriteAddError(StringConstants.failedToAdd));
    }
  }
}
