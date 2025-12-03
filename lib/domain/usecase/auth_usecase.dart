import 'package:dartz/dartz.dart';
import 'package:final_l3/core/network/failure.dart';
import 'package:final_l3/domain/entity/user_entity.dart';
import 'package:final_l3/domain/repository/auth_repository.dart';

class AuthUsecase {
  final AuthRepository repo;

  AuthUsecase({required this.repo});
  Future<Either<Failure, UserEntity>> register(String email, String password) {
    return repo.register(email, password);
  }

  Future<Either<Failure, UserEntity>> login(String email, String password) {
    return repo.login(email, password);
  }
}
