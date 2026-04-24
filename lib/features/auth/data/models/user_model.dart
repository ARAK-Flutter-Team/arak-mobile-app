/*import '../../../../core/entities/user.dart';

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

  /*static UserRole _mapRole(String? role) {
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
  }*/
  static UserRole _mapRole(String? role) {
    final r = role?.trim().toLowerCase();

    switch (r) {
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
        return UserRole.parent; // fallback بدل crash
    }
  }
}*/
/*import '../../../../core/entities/user.dart';

class UserModel extends User {
  final String avatarUrl;
  final int roleId;

  // أضفنا token هنا عشان نستقبله ونمرره للـ User
  final String? token;

  UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.role,
    super.classes = const [],
    required this.avatarUrl,
    required this.roleId,
    required super.subject,
    this.token, // التوكن
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      role: _mapRole(json['role']),
      avatarUrl: json['avatar'] ?? "",
      roleId: (json['roleId'] as num?)?.toInt() ?? 0,
      classes: const [],
      subject: json['subject'],
      // من الـ JSON العادي (للـ Get Current User) التوكن غالباً مش هنا
      token: json['token'],
    );
  }

  // دالة خاصة لاستقبال بيانات اللوجين (التوكن + الـ User)
  factory UserModel.fromLoginJson(Map<String, dynamic> userJson, String token) {
    final model = UserModel.fromJson(userJson);
    return UserModel(
      id: model.id,
      name: model.name,
      email: model.email,
      role: model.role,
      avatarUrl: model.avatarUrl,
      roleId: model.roleId,
      subject: model.subject,
      token: token, // ⚠️ هنا بنحط التوكن اللي جاي من الريسبونس
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
        return UserRole.parent;
    }
  }
}*/
import '../../../../core/entities/user.dart';

class UserModel extends User {
  // نعرفه كحقل محلي وليس في Super
  final int? roleId;

  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.role,
    super.classes = const [],
    super.phone,
    super.avatarUrl,
    // ⚠️ تم حذف super.roleId لأنه غير موجود في الـ User
    super.subject,
    super.token,
    this.roleId, // نعرفه هنا
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString(),
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      role: _mapRole(json['role']),
      avatarUrl: json['avatar'] ?? "",
      // ... باقي الحقول
      subject: json['subject'],
      roleId: json['roleId'], // نعيد تعريفه هنا
      token: json['token'],
    );
  }

  factory UserModel.fromLoginJson(Map<String, dynamic> userJson, String token) {
    return UserModel(
      id: userJson['id']?.toString(),
      name: userJson['name'],
      email: userJson['email'],
      role: _mapRole(userJson['role']),
      avatarUrl: userJson['avatar'] ?? "",
      subject: userJson['subject'],
      roleId: userJson['roleId'], // التعديل هنا أيضاً
      token: token,
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
        return UserRole.parent;
    }
  }
}