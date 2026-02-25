import '../models/user_model.dart';
import '../../domain/usecases/login_params.dart';

abstract class AuthRemoteDataSource {
  /// Login using email, password, and role
  Future<UserModel> login(LoginParams params);
}