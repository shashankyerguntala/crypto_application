import 'package:dartz/dartz.dart';
import 'package:final_l3/core/enums/http_methods.dart';
import 'package:final_l3/core/network/dio_client.dart';
import 'package:final_l3/core/network/failure.dart';
import 'package:final_l3/data/models/coin_model.dart';

class CryptoDataSource {
  final DioClient client;

  CryptoDataSource(this.client);

  Future<Either<Failure, List<CryptoModel>>> getMarketCoins({
    String vsCurrency = "usd",
    String? ids,
  }) async {
    return client.request<List<CryptoModel>>(
      HttpMethods.get,
      "coins/markets",
      queryParams: {"vs_currency": vsCurrency, if (ids != null) "ids": ids},
      parser: (data) {
        final list = data as List<dynamic>;
        return list.map((e) => CryptoModel.fromJson(e)).toList();
      },
    );
  }
}
