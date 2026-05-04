import '../../data/models/user_model.dart';
import '../repositories/user_repository.dart';

class GetAllUsersUseCase {
  final UserRepository repository;

  GetAllUsersUseCase(this.repository);

  Future<List<UserModel>> call() {
    return repository.getAllUsers();
  }
}