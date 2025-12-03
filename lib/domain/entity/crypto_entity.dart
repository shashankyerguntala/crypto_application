import 'package:equatable/equatable.dart';

class CryptoEntity extends Equatable {
  final String id;
  final String symbol;
  final String name;
  final String image;

  final double currentPrice;
  final double marketCap;
  final int marketCapRank;

  final double high24h;
  final double low24h;

  final double priceChange24h;
  final double priceChangePercentage24h;
  final double priceChange1h;

  const CryptoEntity({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
    required this.marketCap,
    required this.marketCapRank,
    required this.high24h,
    required this.low24h,
    required this.priceChange24h,
    required this.priceChangePercentage24h,
    required this.priceChange1h,
  });

  CryptoEntity copyWith({
    String? id,
    String? symbol,
    String? name,
    String? image,
    double? currentPrice,
    double? marketCap,
    int? marketCapRank,
    double? high24h,
    double? low24h,
    double? priceChange24h,
    double? priceChangePercentage24h,
    double? priceChange1h,
  }) {
    return CryptoEntity(
      id: id ?? this.id,
      symbol: symbol ?? this.symbol,
      name: name ?? this.name,
      image: image ?? this.image,
      currentPrice: currentPrice ?? this.currentPrice,
      marketCap: marketCap ?? this.marketCap,
      marketCapRank: marketCapRank ?? this.marketCapRank,
      high24h: high24h ?? this.high24h,
      low24h: low24h ?? this.low24h,
      priceChange24h: priceChange24h ?? this.priceChange24h,
      priceChangePercentage24h:
          priceChangePercentage24h ?? this.priceChangePercentage24h,
      priceChange1h: priceChange1h ?? this.priceChange1h,
    );
  }

  @override
  List<Object?> get props => [
        id,
        symbol,
        name,
        image,
        currentPrice,
        marketCap,
        marketCapRank,
        high24h,
        low24h,
        priceChange24h,
        priceChangePercentage24h,
        priceChange1h,
      ];
}
