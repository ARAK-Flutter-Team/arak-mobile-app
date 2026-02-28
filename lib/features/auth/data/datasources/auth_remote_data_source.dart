/*import '../models/user_model.dart';
import '../../domain/params/login_params.dart';

abstract class AuthRemoteDataSource {
  /// Login using email, password, and role
  Future<UserModel> login(LoginParams params);
  Future<UserModel> socialLogin({
    required String idToken,
    required String provider,
  });
}*/
import '../models/user_model.dart';
import '../../domain/params/login_params.dart';

abstract class AuthRemoteDataSource {
  /// Login using email, password, and role
  Future<UserModel> login(LoginParams params);

  /// Get current logged-in user (using stored token)
  Future<UserModel> getCurrentUser();
}