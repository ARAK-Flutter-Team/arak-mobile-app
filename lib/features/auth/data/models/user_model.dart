/*import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.role,
    super.classes = const [],
  });

  /// --- Fake Data Factory ---
  /// تستخدم دلوقتي محاكاة بيانات وهمية
  factory UserModel.fake() {
    return UserModel(
      id: 1,
      name: "Noha Mahmoud",
      email: "noha@example.com",
      role: UserRole.teacher,
      classes: ["Class A", "Class B", "Class C"],
    );
  }

  /// --- From JSON (جاهز للباك لاحقًا) ---
  factory UserModel.fromJson(Map<String, dynamic> json) {
    // عندما يكون الباك جاهز، استخدمي هذا الجزء
    // return UserModel(
    //   id: (json['id'] as num?)?.toInt() ?? 0,
    //   name: json['name'] as String? ?? '',
    //   email: json['email'] as String? ?? '',
    //   role: _mapRole(json['role']),
    // );

    // حالياً نستخدم الفيك
    return UserModel.fake();
  }

  /// --- Helper to map role string to enum (جاهز للباك) ---
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

  /// --- To JSON (جاهز للباك) ---
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "role": role.name,
      "classes": classes,
    };
  }
}*/
import '../../../../core/entities/user.dart';

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
}