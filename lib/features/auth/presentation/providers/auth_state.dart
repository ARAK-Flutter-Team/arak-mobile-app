import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? emailError;
  final String? passwordError;
  final String? accountError;

  const AuthState({
    required this.isLoading,
    required this.isSuccess,
    this.emailError,
    this.passwordError,
    this.accountError,
  });

  factory AuthState.initial() => const AuthState(
    isLoading: false,
    isSuccess: false,
    emailError: null,
    passwordError: null,
    accountError: null,
  );

  AuthState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? emailError,
    String? passwordError,
    String? accountError,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
      accountError: accountError ?? this.accountError,
    );
  }

  @override
  List<Object?> get props =>
      [isLoading, isSuccess, emailError, passwordError, accountError];
}