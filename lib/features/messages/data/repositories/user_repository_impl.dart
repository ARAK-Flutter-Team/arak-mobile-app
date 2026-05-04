import '../../domain/repositories/user_repository.dart';
import '../datasource/user_remote_datasource.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<UserModel>> searchUsers(String email) async {
    if (email.isEmpty || email.length < 1) {
      return [];
    }
    return await remoteDataSource.searchUsers(email);
  }

  @override
  Future<List<UserModel>> getAllUsers() {
    return remoteDataSource.getAllUsers();
  }
}