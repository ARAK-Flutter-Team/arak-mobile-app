import 'package:arak_app/features/auth/presentation/providers/auth_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/social_login.dart';
import '../../domain/params/login_params.dart';
import '../../domain/params/social_login_params.dart';
import 'auth_state.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
      (ref) => AuthNotifier(
    ref.read(loginUseCaseProvider),
    ref.read(socialLoginUseCaseProvider),
  ),
);

class AuthNotifier extends StateNotifier<AuthState> {
  final Login loginUseCase;
  final SocialLogin socialLoginUseCase;

  AuthNotifier(this.loginUseCase, this.socialLoginUseCase)
      : super(AuthState.initial());

  /// --- Login Email/Password ---
  Future<void> login({
    required String email,
    required String password,
    required String? role,
  }) async {
    state = state.copyWith(isSuccess: false);

    if (email.isEmpty) {
      state = state.copyWith(emailError: "Email is required");
      return;
    } else if (!_isValidEmail(email)) {
      state = state.copyWith(emailError: "Invalid email format");
      return;
    } else {
      state = state.copyWith(emailError: null); // تختفي لما صح
    }

    if (password.isEmpty) {
      state = state.copyWith(passwordError: "Password is required");
      return;
    } else {
      state = state.copyWith(passwordError: null); // تختفي لما صح
    }

    if (role == null) {
      state = state.copyWith(accountError: "Select account type");
      return;
    } else {
      state = state.copyWith(accountError: null); // تختفي لما صح
    }
    state = state.copyWith(isLoadingLogin: true);

    final result = await loginUseCase(
        LoginParams(email: email, password: password, role: role!));

    result.fold(
          (failure) => state = state.copyWith(isLoadingLogin: false),
          (user) => state = state.copyWith(
        isLoadingLogin: false,
        isSuccess: true,
      ),
    );
  }

  /// --- Social Login (Google/Apple) ---
  Future<void> socialLogin({
    required String idToken,
    required String provider, // "google" أو "apple"
  }) async {
    // Loading خاص لكل مزود
    if (provider == "google") {
      state = state.copyWith(isLoadingGoogle: true, isSuccess: false);
    } else if (provider == "apple") {
      state = state.copyWith(isLoadingApple: true, isSuccess: false);
    }

    final result = await socialLoginUseCase(
        SocialLoginParams(idToken: idToken, provider: provider));

    result.fold(
          (failure) {
        if (provider == "google") {
          state = state.copyWith(isLoadingGoogle: false);
        } else {
          state = state.copyWith(isLoadingApple: false);
        }
      },
          (user) {
        if (provider == "google") {
          state = state.copyWith(isLoadingGoogle: false, isSuccess: true);
        } else {
          state = state.copyWith(isLoadingApple: false, isSuccess: true);
        }
      },
    );
  }

  /// --- Field Validators ---
  void validateEmail(String email) {
    if (email.isEmpty) {
      state = state.copyWith(emailError: "Email is required");
    } else if (!_isValidEmail(email)) {
      state = state.copyWith(emailError: "Invalid email format");
    } else {
      state = state.copyWith(emailError: null);
    }
  }

  void validatePassword(String password) {
    if (password.isEmpty) {
      state = state.copyWith(passwordError: "Password is required");
    } else {
      state = state.copyWith(passwordError: null);
    }
  }

  void clearAccountError() => state = state.copyWith(accountError: null);

  /// --- Email Regex ---
  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegex.hasMatch(email);
  }
}