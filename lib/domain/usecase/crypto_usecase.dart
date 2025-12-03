import 'package:dartz/dartz.dart';
import 'package:final_l3/core/network/failure.dart';
import 'package:final_l3/domain/entity/crypto_entity.dart';
import 'package:final_l3/domain/repository/crypto_repository.dart';

class CryptoUsecase {
  final CryptoRepository repository;

  CryptoUsecase(this.repository);

  Future<Either<Failure, List<CryptoEntity>>> call() {
    return repository.getMarketCoins();
  }
}
