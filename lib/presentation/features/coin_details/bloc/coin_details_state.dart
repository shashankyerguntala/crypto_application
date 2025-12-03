part of 'coin_details_bloc.dart';

sealed class CoinDetailsState extends Equatable {
  const CoinDetailsState();
  
  @override
  List<Object> get props => [];
}

final class CoinDetailsInitial extends CoinDetailsState {}
