import 'package:get_it/get_it.dart';
import 'package:hamro_grocery_mobile/core/network/hive_service.dart';
import 'package:hamro_grocery_mobile/feature/auth/data/data_source/local_datasource/auth_local_data_source.dart';
import 'package:hamro_grocery_mobile/feature/auth/data/repository/local_repository/auth_local_repository.dart';
import 'package:hamro_grocery_mobile/feature/auth/domain/usecase/login_usecase.dart';
import 'package:hamro_grocery_mobile/feature/auth/domain/usecase/register_usecase.dart';
import 'package:hamro_grocery_mobile/feature/auth/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:hamro_grocery_mobile/feature/auth/presentation/view_model/register_view_model/register_view_model.dart';

final serviceLocator = GetIt.instance;

Future initDependencies() async {
  await _initHiveService();
  await _initAuthModule();
  // await _initSplashModule();
  // await _initHomeModule();
}

// Future<void> _initSplashModule() async {
//   serviceLocator.registerFactory(() => SplashViewModel());
// }

Future _initHiveService() async {
  serviceLocator.registerLazySingleton<HiveService>(() => HiveService());
}

Future<void> _initAuthModule() async {
  // ===================== Data Source ====================
  serviceLocator.registerFactory(
    () => UserLocalDataSource(hiveService: serviceLocator<HiveService>()),
  );

  // ===================== Repository ====================

  serviceLocator.registerFactory(
    () => AuthLocalRepository(
      userLocalDataSource: serviceLocator<UserLocalDataSource>(),
    ),
  );

  serviceLocator.registerFactory(
    () =>
        UserLoginUseCase(authRepository: serviceLocator<AuthLocalRepository>()),
  );

  serviceLocator.registerFactory(
    () => UserRegisterUseCase(
      authRepository: serviceLocator<AuthLocalRepository>(),
    ),
  );

  // ===================== ViewModels ====================

  serviceLocator.registerFactory<RegisterViewModel>(
    () => RegisterViewModel(serviceLocator<UserRegisterUseCase>()),
  );

  // Register LoginViewModel WITHOUT HomeViewModel to avoid circular dependency
  serviceLocator.registerFactory(
    () => LoginViewModel(serviceLocator<UserLoginUseCase>()),
  );
}

// Future<void> _initHomeModule() async {
//   serviceLocator.registerFactory(
//     () => HomeViewModel(loginViewModel: serviceLocator<LoginViewModel>()),
//   );
