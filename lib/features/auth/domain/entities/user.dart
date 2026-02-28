/*import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String role;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  @override
  List<Object> get props => [id, name, email, role];
}*/
import 'package:equatable/equatable.dart';

enum UserRole { admin, teacher, parent }

class User extends Equatable {
  final int id;
  final String name;
  final String email;
  final UserRole role;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  /// --- لو هتربطي مع الباك بعدين، ممكن تضيفي fromJson و toJson ---
  /*
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      role: _mapRole(json['role']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role.name,
    };
  }

  static UserRole _mapRole(String role) {
    switch (role.toLowerCase()) {
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
  */

  @override
  List<Object> get props => [id, name, email, role];
}