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
import '../../../../core/entities/user.dart';
import '../models/user_model.dart';
import '../../domain/params/login_params.dart';
import 'auth_remote_data_source.dart';

class FakeAuthRemoteDataSource implements AuthRemoteDataSource {
  @override
  Future<UserModel> login(LoginParams params) async {
    await Future.delayed(const Duration(seconds: 1));

    // Admin
    if (params.email == "admin@test.com" &&
        params.password == "123456" &&
        params.role == "Admin") {
      return UserModel(
        id: 1,
        name: "Admin User",
        email: params.email,
        role: UserRole.admin,
        avatarUrl: "https://i.pravatar.cc/150?img=1",
        classes: [],
      );
    }

    // Teacher
    if (params.email == "teacher@test.com" &&
        params.password == "123456" &&
        params.role == "Teacher") {
      return UserModel(
        id: 2,
        name: "Ahmed Abdullah",
        email: params.email,
        role: UserRole.teacher,
        avatarUrl: "https://i.pravatar.cc/150?img=3",
        classes: ["Math", "Physics"],
      );
    }

    // Parent
    if (params.email == "parent@test.com" &&
        params.password == "123456" &&
        params.role == "Parent") {
      return UserModel(
        id: 3,
        name: "shenouda romany",
        email: params.email,
        role: UserRole.parent,
        avatarUrl: "https://i.pravatar.cc/150?img=5",
        classes: ["Class A", "Class B"],
      );
    }

    throw Exception("Invalid email or password");
  }

  @override
  Future<UserModel> getCurrentUser() async {
    await Future.delayed(const Duration(seconds: 1));

    return UserModel(
      id: 2,
      name: "Ahmed Abdullah",
      email: "teacher@test.com",
      role: UserRole.teacher,
      avatarUrl: "https://i.pravatar.cc/150?img=3",
      classes: ["Math", "Physics"],
    );
  }
}
