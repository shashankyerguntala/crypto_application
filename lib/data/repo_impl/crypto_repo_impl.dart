import 'package:dartz/dartz.dart';
import 'package:final_l3/core/network/failure.dart';
import 'package:final_l3/data/data_sources/remote_data_sources/crypto_remote_data_source.dart';
import 'package:final_l3/domain/entity/crypto_entity.dart';
import 'package:final_l3/domain/repository/crypto_repository.dart';

class CryptoRepositoryImpl implements CryptoRepository {
  final CryptoRemoteDataSource remoteDataSource;

  CryptoRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<CryptoEntity>>> getMarketCoins() async {
    final result = await remoteDataSource.getMarketCoins();

    return result.map((list) => list.map((e) => e as CryptoEntity).toList());
  }
}
