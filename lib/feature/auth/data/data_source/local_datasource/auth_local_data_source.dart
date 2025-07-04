import 'package:hamro_grocery_mobile/core/network/hive_service.dart';
import 'package:hamro_grocery_mobile/feature/auth/data/data_source/auth_data_source.dart';
import 'package:hamro_grocery_mobile/feature/auth/data/model/auth_hive_model.dart';
import 'package:hamro_grocery_mobile/feature/auth/domain/entity/auth_entity.dart';

class UserLocalDataSource implements IAuthDataSource {
  final HiveService _hiveService;

  UserLocalDataSource({required HiveService hiveService})
    : _hiveService = hiveService;

  @override
  Future<String> loginUser(String email, String password) async {
    try {
      final userData = await _hiveService.login(email, password);
      if (userData != null && userData.password == password) {
        return "Login successful";
      } else {
        throw Exception('Invalid email or password');
      }
    } catch (e) {
      throw Exception('Login Failed : $e');
    }
  }

  @override
  Future<void> registerUser(AuthEntity entity) async {
    try {
      final userHiveModel = UserHiveModel.fromEntity(entity);
      await _hiveService.register(userHiveModel);
    } catch (e) {
      throw Exception("Registration Failed : $e");
    }
  }
}
