import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? userId;
  final String name;
  final String email;
  final String password;
  final String phone;

  const AuthEntity({
    this.userId,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [userId, name, email, password, phone];
}