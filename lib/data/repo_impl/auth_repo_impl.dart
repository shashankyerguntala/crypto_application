import 'package:dartz/dartz.dart';
import 'package:final_l3/core/constants/string_constants.dart';
import 'package:final_l3/core/network/failure.dart';
import 'package:final_l3/data/data_sources/local_data_sources/auth_local_data_source.dart';
import 'package:final_l3/domain/entity/user_entity.dart';
import 'package:final_l3/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource local;

  AuthRepositoryImpl(this.local);

  bool validEmail(String email) {
    final regex = RegExp(StringConstants.emailRegex);
    return regex.hasMatch(email);
  }

  @override
  Future<Either<Failure, UserEntity>> register(
    String email,
    String password,
  ) async {
    try {
      if (!validEmail(email)) {
        return Left(Failure(msg: StringConstants.invalidMail));
      }

      final existing = local.getUserPassword(email);
      if (existing != null) {
        return Left(Failure(msg: "User already exists"));
      }

      await local.saveUser(email, password);

      return Right(UserEntity(email: email));
    } catch (e) {
      return Left(Failure(msg: "Registration failed"));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> login(
    String email,
    String password,
  ) async {
    try {
      final savedPassword = local.getUserPassword(email);

      if (savedPassword == null) {
        return Left(Failure(msg: "User not found"));
      }

      if (savedPassword != password) {
        return Left(Failure(msg: "Incorrect password"));
      }

      return Right(UserEntity(email: email));
    } catch (e) {
      return Left(Failure(msg: "Login failed"));
    }
  }
}
