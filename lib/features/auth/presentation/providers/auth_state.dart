/*import 'package:equatable/equatable.dart';

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
}*/
import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  final bool isLoadingLogin;    // Email/password login
  final bool isLoadingGoogle;   // Google login
  final bool isLoadingApple;    // Apple login
  final bool isSuccess;
  final String? emailError;
  final String? passwordError;
  final String? accountError;

  const AuthState({
    required this.isLoadingLogin,
    required this.isLoadingGoogle,
    required this.isLoadingApple,
    required this.isSuccess,
    this.emailError,
    this.passwordError,
    this.accountError,
  });

  factory AuthState.initial() => const AuthState(
    isLoadingLogin: false,
    isLoadingGoogle: false,
    isLoadingApple: false,
    isSuccess: false,
    emailError: null,
    passwordError: null,
    accountError: null,
  );
  AuthState copyWith({
    bool? isLoadingLogin,
    bool? isLoadingGoogle,
    bool? isLoadingApple,
    bool? isSuccess,
    String? emailError,
    String? passwordError,
    String? accountError,
    bool clearEmailError = false,
    bool clearPasswordError = false,
    bool clearAccountError = false,
  }) {
    return AuthState(
      isLoadingLogin: isLoadingLogin ?? this.isLoadingLogin,
      isLoadingGoogle: isLoadingGoogle ?? this.isLoadingGoogle,
      isLoadingApple: isLoadingApple ?? this.isLoadingApple,
      isSuccess: isSuccess ?? this.isSuccess,
      emailError: clearEmailError ? null : (emailError ?? this.emailError),
      passwordError: clearPasswordError ? null : (passwordError ?? this.passwordError),
      accountError: clearAccountError ? null : (accountError ?? this.accountError),
    );
  }
  /*AuthState copyWith({
    bool? isLoadingLogin,
    bool? isLoadingGoogle,
    bool? isLoadingApple,
    bool? isSuccess,
    String? emailError,
    String? passwordError,
    String? accountError,
  }) {
    return AuthState(
      isLoadingLogin: isLoadingLogin ?? this.isLoadingLogin,
      isLoadingGoogle: isLoadingGoogle ?? this.isLoadingGoogle,
      isLoadingApple: isLoadingApple ?? this.isLoadingApple,
      isSuccess: isSuccess ?? this.isSuccess,
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
      accountError: accountError ?? this.accountError,
    );
  }*/

  @override
  List<Object?> get props => [
    isLoadingLogin,
    isLoadingGoogle,
    isLoadingApple,
    isSuccess,
    emailError,
    passwordError,
    accountError,
  ];
}