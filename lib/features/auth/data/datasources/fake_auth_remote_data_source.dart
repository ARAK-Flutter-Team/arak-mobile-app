/*import '../../domain/entities/user.dart';
import '../models/user_model.dart';
import '../../domain/params/login_params.dart';
import 'auth_remote_data_source.dart';

class FakeAuthRemoteDataSource implements AuthRemoteDataSource {
  @override
  Future<UserModel> login(LoginParams params) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // ✅ Fake user data
    return UserModel(
      id: 1,
      name: "Noha Mahmoud",
      email: params.email,
      role: UserRole.parent, // ممكن تغيريها حسب الاختيار من الdropdown
    );
  }

  @override
  Future<UserModel> getCurrentUser() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // ✅ Fake user data
    return UserModel(
      id: 1,
      name: "Noha Mahmoud",
      email: "noha@example.com",
      role: UserRole.teacher,
      classes: ["Class A", "Class B", "Class C"],
    );
  }
}*/
import '../../domain/entities/user.dart';
import '../models/user_model.dart';
import '../../domain/params/login_params.dart';
import 'auth_remote_data_source.dart';

class FakeAuthRemoteDataSource implements AuthRemoteDataSource {

  @override
  Future<UserModel> login(LoginParams params) async {

    await Future.delayed(const Duration(seconds: 1));

    return UserModel(
      id: 1,
      name: "Noha Mahmoud",
      email: params.email,
      role: UserRole.parent,
      avatarUrl: "https://i.pravatar.cc/150?img=5",
      classes: ["Class A", "Class B"],
    );
  }

  @override
  Future<UserModel> getCurrentUser() async {

    await Future.delayed(const Duration(seconds: 1));

    return UserModel(
      id: 1,
      name: "Noha Mahmoud",
      email: "noha@example.com",
      role: UserRole.teacher,
      avatarUrl: "https://i.pravatar.cc/150?img=3",
      classes: ["Class A", "Class B", "Class C"],
    );
  }
}