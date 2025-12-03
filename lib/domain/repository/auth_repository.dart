import 'package:dartz/dartz.dart';
import 'package:final_l3/core/network/failure.dart';
import 'package:final_l3/domain/entity/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> register(String email, String password);
  Future<Either<Failure, UserEntity>> login(String email, String password);
}
