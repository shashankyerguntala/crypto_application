part of 'favourites_bloc.dart';

abstract class FavouritesEvent extends Equatable {
  const FavouritesEvent();

  @override
  List<Object?> get props => [];
}

class LoadFavouritesEvent extends FavouritesEvent {}

class AddFavouriteEvent extends FavouritesEvent {
  final CryptoModel coin;

  const AddFavouriteEvent(this.coin);

  @override
  List<Object?> get props => [coin];
}

class RemoveFavouriteEvent extends FavouritesEvent {
  final String coinId;

  const RemoveFavouriteEvent(this.coinId);

  @override
  List<Object?> get props => [coinId];
}
