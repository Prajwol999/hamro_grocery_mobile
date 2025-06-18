import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hamro_grocery_mobile/app/usecase/usecase.dart';
import 'package:hamro_grocery_mobile/core/error/failure.dart';
import 'package:hamro_grocery_mobile/feature/auth/domain/repository/auth_repository.dart';


class LoginParams extends Equatable {
  final String email;

  final String password;

  const LoginParams({required this.email, required this.password});

  @override
  // TODO: implement props
  List<Object?> get props => [email, password];
}

class UserLoginUseCase implements UseCaseWithParams<String, LoginParams> {
  final IAuthRepository _authRepository;

  UserLoginUseCase({required IAuthRepository authRepository})
    : _authRepository = authRepository;

  @override
  Future<Either<Failure, String>> call(LoginParams params) async {
    return await _authRepository.loginUser(params.email, params.password);
  }
}