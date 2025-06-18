
import 'package:hamro_grocery_mobile/feature/auth/domain/entity/auth_entity.dart';
abstract interface class IAuthDataSource {
  Future<void> loginUser(String email, String password);

  Future<void> registerUser(AuthEntity entity);
}