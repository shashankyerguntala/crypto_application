part of 'coin_details_bloc.dart';

abstract class CoinDetailsState extends Equatable {
  const CoinDetailsState();

  @override
  List<Object?> get props => [];
}

class CoinDetailsInitial extends CoinDetailsState {}

class FavouriteAddLoading extends CoinDetailsState {}

class FavouriteAddSuccess extends CoinDetailsState {}

class FavouriteAddError extends CoinDetailsState {
  final String message;

  const FavouriteAddError(this.message);

  @override
  List<Object?> get props => [message];
}
