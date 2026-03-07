import 'package:equatable/equatable.dart';
import '../../../../core/entities/user.dart';

class AuthState extends Equatable {
  final bool isLoadingLogin;
  final bool isSuccess;

  final String? emailError;
  final String? passwordError;
  final String? accountError;
  final String? generalError;

  final User? user;

  const AuthState({
    required this.isLoadingLogin,
    required this.isSuccess,
    this.emailError,
    this.passwordError,
    this.accountError,
    this.generalError,
    this.user,
  });

  factory AuthState.initial() => const AuthState(
    isLoadingLogin: false,
    isSuccess: false,
    emailError: null,
    passwordError: null,
    accountError: null,
    generalError: null,
    user: null,
  );

  AuthState copyWith({
    bool? isLoadingLogin,
    bool? isSuccess,
    String? emailError,
    String? passwordError,
    String? accountError,
    String? generalError,
    User? user,
  }) {
    return AuthState(
      isLoadingLogin: isLoadingLogin ?? this.isLoadingLogin,
      isSuccess: isSuccess ?? this.isSuccess,
      emailError: emailError,
      passwordError: passwordError,
      accountError: accountError,
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
    accountError,
    generalError,
    user,
  ];
}