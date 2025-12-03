import 'package:final_l3/domain/entity/crypto_entity.dart';

class CryptoModel extends CryptoEntity {
  const CryptoModel({
    required super.id,
    required super.symbol,
    required super.name,
    required super.image,
    required super.currentPrice,
    required super.marketCap,
    required super.marketCapRank,
    required super.high24h,
    required super.low24h,
    required super.priceChange24h,
    required super.priceChangePercentage24h,
    required super.priceChange1h,
  });

  factory CryptoModel.fromJson(Map<String, dynamic> json) {
    double toDouble(value) {
      if (value is num) {
        return value.toDouble();
      }
      return double.tryParse(value.toString()) ?? 0.0;
    }

    int toInt(value) {
      if (value is num) {
        return value.toInt();
      }
      return int.tryParse(value.toString()) ?? 0;
    }

    return CryptoModel(
      id: json["id"] ?? "",
      symbol: json["symbol"] ?? "",
      name: json["name"] ?? "",
      image: json["image"] ?? "",
      currentPrice: toDouble(json["current_price"]),
      marketCap: toDouble(json["market_cap"]),
      marketCapRank: toInt(json["market_cap_rank"]),
      high24h: toDouble(json["high_24h"]),
      low24h: toDouble(json["low_24h"]),
      priceChange24h: toDouble(json["price_change_24h"]),
      priceChangePercentage24h: toDouble(json["price_change_percentage_24h"]),
      priceChange1h: toDouble(json["price_change_percentage_1h_in_currency"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "symbol": symbol,
    "name": name,
    "image": image,
    "current_price": currentPrice,
    "market_cap": marketCap,
    "market_cap_rank": marketCapRank,
    "high_24h": high24h,
    "low_24h": low24h,
    "price_change_24h": priceChange24h,
    "price_change_percentage_24h": priceChangePercentage24h,
    "price_change_percentage_1h_in_currency": priceChange1h,
  };
}
