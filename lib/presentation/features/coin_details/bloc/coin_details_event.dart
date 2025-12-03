part of 'coin_details_bloc.dart';

abstract class CoinDetailsEvent extends Equatable {
  const CoinDetailsEvent();

  @override
  List<Object?> get props => [];
}

class AddToFavouritesEvent extends CoinDetailsEvent {
  final CryptoModel coin;

  const AddToFavouritesEvent(this.coin);

  @override
  List<Object?> get props => [coin];
}
