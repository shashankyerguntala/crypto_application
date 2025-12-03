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
      final list = hiveUseCase.getFavourites();

      final exists = list.any((coin) => coin.id == event.coin.id);
      if (exists) {
        emit(FavouriteAddError(StringConstants.alreadyFav));
        return;
      }

      list.add(event.coin);

      await hiveUseCase.saveFavourites(list);

      emit(FavouriteAddSuccess());
    } catch (e) {
      emit(FavouriteAddError(StringConstants.failedToAdd));
    }
  }
}
