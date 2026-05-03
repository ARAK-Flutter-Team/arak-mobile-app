import 'package:equatable/equatable.dart';
import '../../../../core/entities/user.dart';

class AuthState extends Equatable {
  final bool isLoadingLogin;
  final bool isSuccess;

  final String? emailError;
  final String? passwordError;
  final String? generalError;

  final User? user;

  const AuthState({
    required this.isLoadingLogin,
    required this.isSuccess,
    this.emailError,
    this.passwordError,
    this.generalError,
    this.user,
  });

  factory AuthState.initial() => const AuthState(
    isLoadingLogin: false,
    isSuccess: false,
    emailError: null,
    passwordError: null,
    generalError: null,
    user: null,
  );

  AuthState copyWith({
    bool? isLoadingLogin,
    bool? isSuccess,
    String? emailError,
    String? passwordError,
    String? generalError,
    User? user,
  }) {
    return AuthState(
      isLoadingLogin: isLoadingLogin ?? this.isLoadingLogin,
      isSuccess: isSuccess ?? this.isSuccess,
      emailError: emailError,
      passwordError: passwordError,
      generalError: generalError ?? this.generalError,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [
    isLoadingLogin,
    isSuccess,
    emailError,
    passwordError,
    generalError,
    user,
  ];
}