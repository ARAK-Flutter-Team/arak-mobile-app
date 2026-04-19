/*import '../../../../core/entities/user.dart';

class UserModel extends User {

  final String avatarUrl;

  UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.role,
    super.classes = const [],
    required this.avatarUrl,
  });

  /// Fake Data
  factory UserModel.fake() {
    return UserModel(
      id: 1,
      name: "Noha Mahmoud",
      email: "noha@example.com",
      role: UserRole.teacher,
      avatarUrl:
      "https://i.pravatar.cc/150?img=3",
      classes: ["Class A", "Class B", "Class C"],
    );
  }

  /// From JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      role: _mapRole(json['role']),
      avatarUrl: json['avatar'] ?? "",
      classes: List<String>.from(json['classes'] ?? []),
    );
  }

  static UserRole _mapRole(String? role) {
    switch (role?.toLowerCase()) {
      case 'admin':
        return UserRole.admin;
      case 'teacher':
        return UserRole.teacher;
      case 'parent':
        return UserRole.parent;
      default:
        throw Exception('Invalid role');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "role": role.name,
      "avatar": avatarUrl,
      "classes": classes,
    };
  }
}*/
/*import '../../../../core/entities/user.dart';

class UserModel extends User {

  final String avatarUrl;

  UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.role,
    super.classes = const [],
    required this.avatarUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      role: _mapRole(json['role']),
      avatarUrl: json['avatar'] ?? "",
      classes: [], // الباك مش بيرجع classes
    );
  }

  static UserRole _mapRole(String? role) {
    switch (role?.toLowerCase()) {
      case 'admin':
        return UserRole.admin;
      case 'teacher':
        return UserRole.teacher;
      case 'parent':
        return UserRole.parent;
      default:
        throw Exception('Invalid role');
    }
  }
}*/
import '../../../../core/entities/user.dart';

class UserModel extends User {
  final String avatarUrl;
  final int roleId;

  UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.role,
    super.classes = const [],
    required this.avatarUrl,
    required this.roleId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      role: _mapRole(json['role']),
      avatarUrl: json['avatar'] ?? "",
      roleId: (json['roleId'] as num?)?.toInt() ?? 0,
      classes: const [], // الباك مش بيرجعها حاليًا
    );
  }

  static UserRole _mapRole(String? role) {
    switch (role?.toLowerCase()) {
      case 'admin':
      case 'super admin':
      case 'academic admin':
      case 'fees admin':
      case 'users admin':
        return UserRole.admin;

      case 'teacher':
        return UserRole.teacher;

      case 'parent':
        return UserRole.parent;

      default:
        throw Exception('Invalid role: $role');
    }
  }
}