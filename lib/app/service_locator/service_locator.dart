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
import 'package:hamro_grocery_mobile/feature/category/domain/repository/category_repository.dart';
import 'package:hamro_grocery_mobile/feature/category/domain/usecase/get_all_category_usecase.dart';
import 'package:hamro_grocery_mobile/feature/category/presentation/view_model/category_view_model.dart';
import 'package:hamro_grocery_mobile/feature/order/data/data_source/cart_remote_data_source.dart';
import 'package:hamro_grocery_mobile/feature/order/data/data_source/order_item_remote_data_source.dart';
import 'package:hamro_grocery_mobile/feature/order/data/repository/cart_remote_repository.dart';
import 'package:hamro_grocery_mobile/feature/order/data/repository/order_remote_repository.dart';
import 'package:hamro_grocery_mobile/feature/order/domain/repository/cart_repository.dart';
import 'package:hamro_grocery_mobile/feature/order/domain/repository/order_repository.dart';
import 'package:hamro_grocery_mobile/feature/order/domain/usecase/add_cart_item_usecase.dart';
import 'package:hamro_grocery_mobile/feature/order/domain/usecase/clear_cart_usecase.dart';
import 'package:hamro_grocery_mobile/feature/order/domain/usecase/create_order_usecase.dart';
import 'package:hamro_grocery_mobile/feature/order/domain/usecase/get_cart_item_usecase.dart';
import 'package:hamro_grocery_mobile/feature/order/domain/usecase/get_my_order_usecase.dart';
import 'package:hamro_grocery_mobile/feature/order/domain/usecase/get_my_payment_history_usecase.dart';
import 'package:hamro_grocery_mobile/feature/order/domain/usecase/remote_cart_item_usecase.dart';
import 'package:hamro_grocery_mobile/feature/order/domain/usecase/update_cart_item_usecase.dart';
import 'package:hamro_grocery_mobile/feature/order/domain/usecase/update_order_usecase.dart';
import 'package:hamro_grocery_mobile/feature/order/presentation/view_model/cart_view_model.dart';
import 'package:hamro_grocery_mobile/feature/order/presentation/view_model/order_view_model.dart';
import 'package:hamro_grocery_mobile/feature/product/data/data_source/remote_data_source/product_remote_data_source.dart';
import 'package:hamro_grocery_mobile/feature/product/data/repository/remote_repository/product_remote_repository.dart';
import 'package:hamro_grocery_mobile/feature/product/domain/repository/product_repository.dart';
import 'package:hamro_grocery_mobile/feature/product/domain/usecase/get_all_product_usecase.dart';
import 'package:hamro_grocery_mobile/feature/product/presentation/view_model/product_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

final serviceLocator = GetIt.instance;

Future initDependencies() async {
  await _initHiveService();
  await _initAuthModule();
  await _initApiService();
  await _initSharedPrefs();
  await _initCategoryModule();
  await _initProductModule();
  await _initCartModule();
  await _initOrderModule();
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
  serviceLocator.registerFactory<ICategoryRepository>(
    () => CategoryRemoteRepository(
      categoryRemoteDataSource: serviceLocator<CategoryRemoteDataSource>(),
    ),
  );

  // ===================== Use Cases ====================
  serviceLocator.registerFactory(
    () => GetAllCategoryUsecase(
      categoryRepository: serviceLocator<ICategoryRepository>(),
    ),
  );

  // ===================== ViewModels ====================
  serviceLocator.registerFactory(
    () => CategoryViewModel(
      getAllCategoryUsecase: serviceLocator<GetAllCategoryUsecase>(),
    ),
  );
}

Future<void> _initProductModule() async {
  // ===================== Data Source ====================
  serviceLocator.registerFactory(
    () => ProductRemoteDataSource(apiService: serviceLocator<ApiService>()),
  );

  // ===================== Repository ====================
  serviceLocator.registerFactory<IProductRepository>(
        () => ProductRemoteRepository(
      productRemoteDataSource: serviceLocator<ProductRemoteDataSource>(),
    ),
  );

  // ===================== Use Cases ====================
  serviceLocator.registerFactory(
    () => GetAllProductUsecase(
      productRepository: serviceLocator<IProductRepository>(),
    ),
  );

  // ===================== ViewModels ====================
  serviceLocator.registerFactory(
    () => ProductViewModel(
      getAllProductUsecase: serviceLocator<GetAllProductUsecase>(),
    ),
  );
}

Future<void> _initCartModule() async {
  // ===================== Data Source ====================
  // Cart uses a local data source with SharedPreferences
  serviceLocator.registerFactory(
    () => CartLocalDataSourceImpl(
      sharedPreferences: serviceLocator<SharedPreferences>(),
    ),
  );

  // ===================== Repository ====================
  serviceLocator.registerFactory<ICartRepository>(
    () => CartRepositoryImpl(
      cartDataSource: serviceLocator<CartLocalDataSourceImpl>(),
    ),
  );

  // ===================== Use Cases ====================
  serviceLocator.registerFactory(
    () =>
        GetCartItemsUseCase(cartRepository: serviceLocator<ICartRepository>()),
  );
  serviceLocator.registerFactory(
    () =>
        AddItemToCartUseCase(cartRepository: serviceLocator<ICartRepository>()),
  );
  serviceLocator.registerFactory(
    () => UpdateCartItemQuantityUseCase(
      cartRepository: serviceLocator<ICartRepository>(),
    ),
  );
  serviceLocator.registerFactory(
    () => RemoveItemFromCartUseCase(
      cartRepository: serviceLocator<ICartRepository>(),
    ),
  );
  serviceLocator.registerFactory(
    () => ClearCartUseCase(cartRepository: serviceLocator<ICartRepository>()),
  );

  // ===================== ViewModel (BLoC) ====================
  // Register as LazySingleton so the same cart instance is used throughout the app
  serviceLocator.registerLazySingleton<CartBloc>(
    () => CartBloc(
      getCartItemsUseCase: serviceLocator<GetCartItemsUseCase>(),
      addItemToCartUseCase: serviceLocator<AddItemToCartUseCase>(),
      updateCartItemQuantityUseCase:
          serviceLocator<UpdateCartItemQuantityUseCase>(),
      removeItemFromCartUseCase: serviceLocator<RemoveItemFromCartUseCase>(),
      clearCartUseCase: serviceLocator<ClearCartUseCase>(),
    ),
  );
}

// ... after _initCartModule ...

Future<void> _initOrderModule() async {
  // ===================== Data Source ====================
  serviceLocator.registerFactory(
    () => OrderRemoteDataSourceImpl(apiService: serviceLocator<ApiService>()),
  );

  // ===================== Repository ====================
  serviceLocator.registerFactory<IOrderRepository>(
    () => OrderRepositoryImpl(
      orderDataSource: serviceLocator<OrderRemoteDataSourceImpl>(),
    ),
  );

  // ===================== Use Cases ====================
  serviceLocator.registerFactory(
    () => CreateOrderUseCase(repository: serviceLocator<IOrderRepository>(), tokenSharedPref: serviceLocator<TokenSharedPrefs>()),
  );
  serviceLocator.registerFactory(
    () => GetMyOrdersUseCase(repository: serviceLocator<IOrderRepository>()),
  );
  serviceLocator.registerFactory(
    () => UpdateOrderStatusUseCase(
      repository: serviceLocator<IOrderRepository>(),
    ),
  );
  serviceLocator.registerFactory(
    () => GetPaymentHistoryUseCase(
      repository: serviceLocator<IOrderRepository>(),
    ),
  );

  // ===================== ViewModel (BLoC) ====================
  // OrderBloc can be a factory because each order screen might manage its own lifecycle.
  // If you want it to persist across screens, you could use LazySingleton here too.
  serviceLocator.registerFactory<OrderBloc>(
    () => OrderBloc(
      createOrderUseCase: serviceLocator<CreateOrderUseCase>(),
      getMyOrdersUseCase: serviceLocator<GetMyOrdersUseCase>(),
      updateOrderStatusUseCase: serviceLocator<UpdateOrderStatusUseCase>(),
      getPaymentHistoryUseCase: serviceLocator<GetPaymentHistoryUseCase>(),
    ),
  );
}
