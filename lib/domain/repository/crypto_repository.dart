import 'package:dartz/dartz.dart';
import 'package:final_l3/core/network/failure.dart';
import 'package:final_l3/domain/entity/crypto_entity.dart';

abstract class CryptoRepository {
  Future<Either<Failure, List<CryptoEntity>>> getMarketCoins();
}
