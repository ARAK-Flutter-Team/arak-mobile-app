/*import 'package:equatable/equatable.dart';

enum UserRole { admin, teacher, parent }

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
}*/
/*import 'package:equatable/equatable.dart';

enum UserRole { admin, teacher, parent }

class User extends Equatable {
  final int id;
  final String name;
  final String email;
  final UserRole role;
  final List<String> classes;
  final String? phone;
  final String? avatarUrl;
  final String? subject;
  final String? token; // ⚠️ 1. إضافة حقل التوكن

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.classes = const [],
    this.phone,
    this.avatarUrl,
    this.subject,
    this.token, // ⚠️ 2. إضافته في الـ Constructor
  });

  User copyWith({
    String? name,
    String? email,
    List<String>? classes,
    String? phone,
    String? avatarUrl,
    String? subject,
    String? token, // ⚠️ 3. إضافته في الـ copyWith
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
      token: token ?? this.token, // ⚠️ 4. إضافته هنا لما نرجع النسخة الجديدة
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
    token, // ⚠️ 5. إضافته في الـ props (مهم جداً عشان الـ Equatable يشتغل)
  ];
}*/
import 'package:equatable/equatable.dart';

enum UserRole { admin, teacher, parent }

class User extends Equatable {
  final String? id; //  1. تغيير النوع لـ String عشان التوكن
  final String name;
  final String email;
  final UserRole role;
  final List<String> classes;
  final String? phone;
  final String? avatarUrl;
  final String? subject;
  final String? token; //  2. تأكدي من وجود التوكن هنا

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.classes = const [],
    this.phone,
    this.avatarUrl,
    this.subject,
    this.token,
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    List<String>? classes,
    String? phone,
    String? avatarUrl,
    String? subject,
    String? token,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role,
      classes: classes ?? this.classes,
      phone: phone ?? this.phone,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      subject: subject ?? this.subject,
      token: token ?? this.token,
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
    token,
  ];
}