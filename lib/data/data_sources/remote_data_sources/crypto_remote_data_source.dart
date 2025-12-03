import 'package:dartz/dartz.dart';
import 'package:final_l3/core/network/dio_client.dart';
import 'package:final_l3/core/network/failure.dart';
import 'package:final_l3/core/enums/http_methods.dart';
import 'package:final_l3/data/models/crypto_model.dart';

abstract class CryptoRemoteDataSource {
  Future<Either<Failure, List<CryptoModel>>> getMarketCoins();
}

class CryptoRemoteDataSourceImpl implements CryptoRemoteDataSource {
  final DioClient client;

  CryptoRemoteDataSourceImpl(this.client);

  @override
  Future<Either<Failure, List<CryptoModel>>> getMarketCoins() async {
    return client.request<List<CryptoModel>>(
      HttpMethods.get,
      "/coins/markets",
      queryParams: {
        "vs_currency": "usd",
        "order": "market_cap_desc",
        "per_page": 100,
        "page": 1,
        "sparkline": false,
        "price_change_percentage": "1h,24h",
      },
      parser: (data) {
        final list = data as List<dynamic>;
        return list.map((e) => CryptoModel.fromJson(e)).toList();
      },
    );
  }
}
