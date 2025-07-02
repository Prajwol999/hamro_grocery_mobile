import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hamro_grocery_mobile/app/shared_pref/token_shared_pref.dart';
import 'package:hamro_grocery_mobile/core/network/api_service.dart';
import 'package:hamro_grocery_mobile/core/network/hive_service.dart';
import 'package:hamro_grocery_mobile/feature/auth/data/data_source/local_datasource/auth_local_data_source.dart';
import 'package:hamro_grocery_mobile/feature/auth/data/data_source/remote_datasource/auth_remote_data_source.dart';
import 'package:hamro_grocery_mobile/feature/auth/data/repository/remote_repository/auth_remote_repository.dart';
import 'package:hamro_grocery_mobile/feature/auth/domain/usecase/login_usecase.dart';
import 'package:hamro_grocery_mobile/feature/auth/domain/usecase/register_usecase.dart';
import 'package:hamro_grocery_mobile/feature/auth/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:hamro_grocery_mobile/feature/auth/presentation/view_model/register_view_model/register_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

final serviceLocator = GetIt.instance;

Future initDependencies() async {
  await _initHiveService();
  await _initAuthModule();
  await _initApiService() ;
  await _initSharedPrefs() ;
  
  // await _initSplashModule();
  // await _initHomeModule();
}

Future _initApiService () async {
  serviceLocator.registerLazySingleton<ApiService>(() => ApiService(Dio())) ;
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
    () => AuthRemoteDataSource(apiService: serviceLocator<ApiService>()  )
  ) ;

  // ===================== Repository ====================

  // serviceLocator.registerFactory(
  //   () => AuthLocalRepository(
  //     userLocalDataSource: serviceLocator<UserLocalDataSource>(),
  //   ),
  // );

  serviceLocator.registerFactory(
    () => AuthRemoteRepository(authRemoteDataSource: serviceLocator<AuthRemoteDataSource>())
  ) ;

  serviceLocator.registerFactory(
    () =>
        UserLoginUseCase(authRepository: serviceLocator<AuthRemoteRepository>() ,
         tokenSharedPrefs: serviceLocator<TokenSharedPrefs>(),) ,
  );

  serviceLocator.registerFactory(
    () => UserRegisterUseCase(
      authRepository: serviceLocator<AuthRemoteRepository>(),
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
}

// Future<void> _initHomeModule() async {
//   serviceLocator.registerFactory(
//     () => HomeViewModel(loginViewModel: serviceLocator<LoginViewModel>()),
//   );
