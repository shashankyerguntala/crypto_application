import 'package:dartz/dartz.dart';
import 'package:final_l3/core/constants/api_constants.dart';
import 'package:final_l3/core/constants/string_constants.dart';
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
      ApiConstants.getCoins,
      queryParams: {
        StringConstants.vsCurrency: StringConstants.usd,
        StringConstants.order: StringConstants.marketCapDesc,
        StringConstants.perPage: 20,
        StringConstants.page: 1,
        StringConstants.sparkline: false,
        StringConstants.priceChangePercentage: StringConstants.priceChange1h24h,
      },
      parser: (data) {
        final list = data as List<dynamic>;
        return list.map((e) => CryptoModel.fromJson(e)).toList();
      },
    );
  }
}
