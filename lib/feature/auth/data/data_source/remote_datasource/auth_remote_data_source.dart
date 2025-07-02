// import 'package:dio/dio.dart';
// import 'package:hamro_grocery_mobile/app/constant/api_endpoints.dart';
// import 'package:hamro_grocery_mobile/core/network/api_service.dart';
// import 'package:hamro_grocery_mobile/feature/auth/data/data_source/auth_data_source.dart';
// import 'package:hamro_grocery_mobile/feature/auth/data/model/user_api_model.dart';
// import 'package:hamro_grocery_mobile/feature/auth/domain/entity/auth_entity.dart';

// class AuthRemoteDataSource implements IAuthDataSource {

//   final ApiService _apiService ;
//   AuthRemoteDataSource({
//     required ApiService apiService 
//   }) : _apiService = apiService ;
  
//   @override
//   Future<void> loginUser(String email, String password) async{
//     try {
//       final response = await _apiService.dio.post(
//         ApiEndpoints.login,
//         data: {'email': email, 'password': password},
//       );
//       print('user response $response') ;
//       if (response.statusCode == 200) {
//         final str = response.data['token'];
//         return str;
//       } else {
//         throw Exception(
//           "Failed to login user : ${response.statusMessage}",
//         );
//       }
//     } on DioException catch (e) {
//       throw Exception("Failed to Login user : ${e.message}");
//     } catch (e) {
//       throw Exception("failed to login user $e");
//     }

//   }

//   @override
//   Future<void> registerUser(AuthEntity entity) async {
//    try {
//       final userApiModel = UserApiModel.fromEntity(entity);
//       final response = await _apiService.dio.post(
//         ApiEndpoints.register,
//         data: userApiModel.toJson(),
//       );
//       print('register response : $response') ;
//       print("api endpoints fixed${ApiEndpoints.register}");
      

//       if (response.statusCode == 200) {
//         return;
//       } else {
//         throw Exception(
//             "Failed to register user : ${response.statusMessage}");
//       }
//     }
//     on DioException catch (e) {
//       throw Exception("Failed to register user : ${e.message}");
//     } catch (e) {
//       throw Exception('Failed to register student : $e');
//     }
//   }

// }