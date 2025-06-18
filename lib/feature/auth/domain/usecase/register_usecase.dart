import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hamro_grocery_mobile/app/usecase/usecase.dart';
import 'package:hamro_grocery_mobile/core/error/failure.dart';
import 'package:hamro_grocery_mobile/feature/auth/domain/entity/auth_entity.dart';
import 'package:hamro_grocery_mobile/feature/auth/domain/repository/auth_repository.dart';


class RegisterUserParams extends Equatable {
  final String name;
  final String phone;
  final String password;
  final String email;

  const RegisterUserParams({
    required this.name,
    required this.password,
    required this.email,
    required this.phone,
  });

  const RegisterUserParams.initial({
    required this.name,
    required this.password,
    required this.email,
    required this.phone,
  });

  @override
  List<Object?> get props => [name, phone, password, email];
}

class UserRegisterUseCase
    implements UseCaseWithParams<void, RegisterUserParams> {
  final IAuthRepository _authRepository;

  UserRegisterUseCase({required IAuthRepository authRepository})
    : _authRepository = authRepository;

  @override
  Future<Either<Failure, void>> call(RegisterUserParams params) {
    final authEntity = AuthEntity(
      name: params.name,
      email: params.email,
      password: params.password,
      phone: params.phone,
    );

    return _authRepository.registerUser(authEntity);
  }
}