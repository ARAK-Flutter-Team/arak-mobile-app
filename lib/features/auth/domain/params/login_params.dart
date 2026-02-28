/*import 'package:equatable/equatable.dart';

class LoginParams extends Equatable {
  final String email;
  final String password;
  final String role;

  const LoginParams({
    required this.email,
    required this.password,
    required this.role,
  });

  @override
  List<Object> get props => [email, password, role];
}*/
import 'package:equatable/equatable.dart';

class LoginParams extends Equatable {
  final String email;
  final String password;
  final String role;

  const LoginParams({
    required this.email,
    required this.password,
    required this.role,
  });

  /// --- جاهز للباك لاحقًا ---
  /*
  factory LoginParams.fromJson(Map<String, dynamic> json) {
    return LoginParams(
      email: json['email'] as String,
      password: json['password'] as String,
      role: json['role'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'role': role,
    };
  }
  */

  @override
  List<Object> get props => [email, password, role];
}