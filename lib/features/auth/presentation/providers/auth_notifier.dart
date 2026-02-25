import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/login_params.dart';
import 'auth_providers.dart';
import 'auth_state.dart';

/// --- AuthNotifier Provider ---
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
      (ref) => AuthNotifier(ref.read(loginUseCaseProvider)),
);

/// --- AuthNotifier Class ---
class AuthNotifier extends StateNotifier<AuthState> {
  final Login loginUseCase;

  AuthNotifier(this.loginUseCase) : super(AuthState.initial());

  /// Login method
  Future<void> login({
    required String email,
    required String password,
    required String? role,
  }) async {

    // Reset success فقط
    state = state.copyWith(isSuccess: false);

    // -------- Validation (one by one) --------

    if (email.isEmpty) {
      state = state.copyWith(emailError: "Email is required");
      return;
    } else if (!_isValidEmail(email)) {
      state = state.copyWith(emailError: "Invalid email format");
      return;
    } else {
      state = state.copyWith(emailError: null);
    }

    if (password.isEmpty) {
      state = state.copyWith(passwordError: "Password is required");
      return;
    } else {
      state = state.copyWith(passwordError: null);
    }

    if (role == null) {
      state = state.copyWith(accountError: "Select account type");
      return;
    } else {
      state = state.copyWith(accountError: null);
    }

    // -------- Loading --------
    state = state.copyWith(isLoading: true);

    final result = await loginUseCase(
      LoginParams(
        email: email,
        password: password,
        role: role!, // مهم
      ),
    );

    result.fold(
          (failure) {
        state = state.copyWith(isLoading: false);
      },
          (user) {
        state = state.copyWith(
          isLoading: false,
          isSuccess: true,
        );
      },
    );
  }

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
  /// Clear individual field errors
  void clearEmailError() {
    state = state.copyWith(emailError: null);
  }

  void clearPasswordError() {
    state = state.copyWith(passwordError: null);
  }

  void clearAccountError() {
    state = state.copyWith(accountError: null);
  }

  /// --- Email Validator ---
  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegex.hasMatch(email);
  }
}
