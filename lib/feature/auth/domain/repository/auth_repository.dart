import 'package:dartz/dartz.dart';
import 'package:hamro_grocery_mobile/core/error/failure.dart';
import 'package:hamro_grocery_mobile/feature/auth/domain/entity/auth_entity.dart';


abstract interface class IAuthRepository {
  Future<Either<Failure, void>> registerUser(AuthEntity user);
  Future<Either<Failure, String>> loginUser(String email, String password);
}