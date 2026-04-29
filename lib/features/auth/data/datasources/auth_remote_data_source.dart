import '../models/user_model.dart';
import '../../domain/params/login_params.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(LoginParams params);

  Future<UserModel> getCurrentUser();

  Future<void> logout();
}