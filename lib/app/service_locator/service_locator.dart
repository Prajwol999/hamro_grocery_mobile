import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hamro_grocery_mobile/app/shared_pref/token_shared_pref.dart';
import 'package:hamro_grocery_mobile/core/network/api_service.dart';
import 'package:hamro_grocery_mobile/core/network/hive_service.dart';
import 'package:hamro_grocery_mobile/feature/auth/data/data_source/local_datasource/auth_local_data_source.dart';
import 'package:hamro_grocery_mobile/feature/auth/data/data_source/remote_datasource/auth_remote_data_source.dart';
import 'package:hamro_grocery_mobile/feature/auth/data/repository/remote_repository/auth_remote_repository.dart';
import 'package:hamro_grocery_mobile/feature/auth/domain/usecase/get_user_usecase.dart';
import 'package:hamro_grocery_mobile/feature/auth/domain/usecase/login_usecase.dart';
import 'package:hamro_grocery_mobile/feature/auth/domain/usecase/register_usecase.dart';
import 'package:hamro_grocery_mobile/feature/auth/domain/usecase/update_user_usecase.dart';
import 'package:hamro_grocery_mobile/feature/auth/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:hamro_grocery_mobile/feature/auth/presentation/view_model/profile_view_model/profile_view_model.dart';
import 'package:hamro_grocery_mobile/feature/auth/presentation/view_model/register_view_model/register_view_model.dart';
import 'package:hamro_grocery_mobile/feature/category/data/data_source/remote_data_source/category_remote_data_source.dart';
import 'package:hamro_grocery_mobile/feature/category/data/repository/remote_repository/category_remote_repository.dart';
import 'package:hamro_grocery_mobile/feature/category/domain/usecase/get_all_category_usecase.dart';
import 'package:hamro_grocery_mobile/feature/category/presentation/view_model/category_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

final serviceLocator = GetIt.instance;

Future initDependencies() async {
  await _initHiveService();
  await _initAuthModule();
  await _initApiService();
  await _initSharedPrefs();
  await _initCategoryModule();

  // await _initSplashModule();
  // await _initHomeModule();
}

Future _initApiService() async {
  serviceLocator.registerLazySingleton<ApiService>(() => ApiService(Dio()));
}

// Future<void> _initSplashModule() async {
//   serviceLocator.registerFactory(() => SplashViewModel());
// }
Future<void> _initSharedPrefs() async {
  // Initialize Shared Preferences if needed
  final sharedPrefs = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPrefs);
  serviceLocator.registerLazySingleton(
    () => TokenSharedPrefs(
      sharedPreferences: serviceLocator<SharedPreferences>(),
    ),
  );
}

Future _initHiveService() async {
  serviceLocator.registerLazySingleton<HiveService>(() => HiveService());
}

Future<void> _initAuthModule() async {
  // ===================== Data Source ====================
  serviceLocator.registerFactory(
    () => UserLocalDataSource(hiveService: serviceLocator<HiveService>()),
  );

  serviceLocator.registerFactory(
    () => AuthRemoteDataSource(apiService: serviceLocator<ApiService>()),
  );

  // ===================== Repository ====================

  // serviceLocator.registerFactory(
  //   () => AuthLocalRepository(
  //     userLocalDataSource: serviceLocator<UserLocalDataSource>(),
  //   ),
  // );

  serviceLocator.registerFactory(
    () => AuthRemoteRepository(
      authRemoteDataSource: serviceLocator<AuthRemoteDataSource>(),
    ),
  );

  serviceLocator.registerFactory(
    () => UserLoginUseCase(
      authRepository: serviceLocator<AuthRemoteRepository>(),
      tokenSharedPrefs: serviceLocator<TokenSharedPrefs>(),
    ),
  );

  serviceLocator.registerFactory(
    () => UserRegisterUseCase(
      authRepository: serviceLocator<AuthRemoteRepository>(),
    ),
  );

  serviceLocator.registerFactory(
    () => GetUserUsecase(
      authRepository: serviceLocator<AuthRemoteRepository>(),
      tokenSharedPrefs: serviceLocator<TokenSharedPrefs>(),
    ),
  );

  serviceLocator.registerFactory(
    () => UserUpdateUsecase(
      authRepository: serviceLocator<AuthRemoteRepository>(),
      tokenSharedPrefs: serviceLocator<TokenSharedPrefs>(),
    ),
  );

  // ===================== ViewModels ====================

  // Register LoginViewModel WITHOUT HomeViewModel to avoid circular dependency
  serviceLocator.registerFactory<RegisterViewModel>(
    () => RegisterViewModel(serviceLocator<UserRegisterUseCase>()),
  );

  // Register LoginViewModel WITHOUT HomeViewModel to avoid circular dependency
  serviceLocator.registerFactory(
    () => LoginViewModel(serviceLocator<UserLoginUseCase>()),
  );

  serviceLocator.registerFactory(
    () => ProfileViewModel(
      userGetUseCase: serviceLocator<GetUserUsecase>(),
      userUpdateUseCase: serviceLocator<UserUpdateUsecase>(),
    ),
  );
}

// Future<void> _initHomeModule() async {
//   serviceLocator.registerFactory(
//     () => HomeViewModel(loginViewModel: serviceLocator<LoginViewModel>()),
//   );

Future<void> _initCategoryModule() async {
  // ===================== Data Source ====================
  serviceLocator.registerFactory(
    () => CategoryRemoteDataSource(apiService: serviceLocator<ApiService>()),
  );

  // ===================== Repository ====================
  serviceLocator.registerFactory(
    () => CategoryRemoteRepository(
      categoryRemoteDataSource: serviceLocator<CategoryRemoteDataSource>(),
    ),
  );

  // ===================== Use Cases ====================
  serviceLocator.registerFactory(
    () => GetAllCategoryUsecase(
      categoryRepository: serviceLocator<CategoryRemoteRepository>(),
    ),
  );

  // ===================== ViewModels ====================
  serviceLocator.registerFactory(
    () => CategoryViewModel(
      getAllCategoryUsecase: serviceLocator<GetAllCategoryUsecase>(),
    ),
  );
}
