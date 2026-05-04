import '../../data/models/user_model.dart';

abstract class UserRepository {
  Future<List<UserModel>> searchUsers(String email);
  Future<List<UserModel>> getAllUsers();
}