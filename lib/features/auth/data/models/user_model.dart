import '../../../../core/entities/user.dart';

class UserModel extends User {
  final int? roleId;

  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.role,
    super.classes = const [],
    super.phone,
    super.avatarUrl,
    super.subject,
    super.token,
    this.roleId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final avatar = json['avatar']?.toString() ?? "";

    return UserModel(
      id: json['id']?.toString(),
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      role: _mapRole(json['role']),
      avatarUrl: (avatar.startsWith('http') || avatar.startsWith('/'))
          ? avatar
          : null,
      subject: json['subject'],
      roleId: json['roleId'],
      token: json['token'],
    );
  }

  //  fromLoginJson
  factory UserModel.fromLoginJson(Map<String, dynamic> userJson, String token) {
    final avatar = userJson['avatar']?.toString() ?? "";

    return UserModel(
      id: userJson['id']?.toString(),
      name: userJson['name'] ?? '',
      email: userJson['email'] ?? '',
      role: _mapRole(userJson['role']),
      avatarUrl:
          (avatar.startsWith('http') || avatar.startsWith('/')) ? avatar : null,
      subject: userJson['subject'],
      roleId: userJson['roleId'],
      token: token,
    );
  }

  static UserRole _mapRole(String? role) {
    switch (role?.trim().toLowerCase()) {
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
