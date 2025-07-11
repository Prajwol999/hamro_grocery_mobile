class ApiEndpoints {
  ApiEndpoints._();

  static const connectionTimeout = Duration(seconds: 1000);
  static const receiveTimeout = Duration(seconds: 1000);

  static const String serverAddress = "http://192.168.1.2:8081";

  static const String baseUrl = "$serverAddress/api/";

  static const String imageUrl = "$serverAddress/uploads/";

  static const String login = "auth/login";
  static const String register = "auth/register";

  static const String getAllCategories = "categories/";

  static const String getAllProducts = "products/";

  // User Profile Endpoints
  static const String getUserProfile = "auth/profile";
  static const String updateUserProfile = "auth/profile/picture";
  static const String forgotPassword = "auth/forgot-password";
  static const String resetPassword = "auth/reset-password/:token";
}
