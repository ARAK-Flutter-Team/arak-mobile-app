import 'package:equatable/equatable.dart';

enum UserRole { admin, teacher, parent }

/*class User extends Equatable {
  final int id;
  final String name;
  final String email;
  final UserRole role;
  final List<String> classes;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.classes = const [],
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
}*/
class User extends Equatable {
  final int id;
  final String name;
  final String email;
  final UserRole role;
  final List<String> classes;
  final String? phone;
  final String? avatarUrl;
  final String? subject; // هنا ضفنا السبجيكت

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.classes = const [],
    this.phone,
    this.avatarUrl,
    this.subject,
  });

  User copyWith({
    String? name,
    String? email,
    List<String>? classes,
    String? phone,
    String? avatarUrl,
    String? subject, // copyWith كمان
  }) {
    return User(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role,
      classes: classes ?? this.classes,
      phone: phone ?? this.phone,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      subject: subject ?? this.subject,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    role,
    classes,
    phone,
    avatarUrl,
    subject,
  ];
}