import '../../data/models/user_model.dart';
import '../repositories/user_repository.dart';

class SearchUsersUseCase {
  final UserRepository repository;

  SearchUsersUseCase(this.repository);

  Future<List<UserModel>> call(String email) {
    return repository.searchUsers(email);
  }
}