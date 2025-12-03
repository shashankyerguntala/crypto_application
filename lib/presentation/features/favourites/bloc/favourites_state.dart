part of 'favourites_bloc.dart';

sealed class FavouritesState extends Equatable {
  const FavouritesState();
  
  @override
  List<Object> get props => [];
}

final class FavouritesInitial extends FavouritesState {}
