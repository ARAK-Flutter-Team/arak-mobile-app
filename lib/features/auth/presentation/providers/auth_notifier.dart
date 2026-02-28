/*import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/login.dart';
import '../../domain/params/login_params.dart';
import 'auth_state.dart';
import 'auth_providers.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
      (ref) => AuthNotifier(
    ref.read(loginUseCaseProvider),
  ),
);

class AuthNotifier extends StateNotifier<AuthState> {
  final Login loginUseCase;

  AuthNotifier(this.loginUseCase)
      : super(AuthState.initial());

  /// --- Login Email/Password ---
  Future<void> login({
    required String email,
    required String password,
    required String? role,
  }) async {
    state = state.copyWith(
      isSuccess: false,
      generalError: null,
    );

    // Email validation
    if (email.isEmpty) {
      state = state.copyWith(emailError: "Email is required");
      return;
    } else if (!_isValidEmail(email)) {
      state = state.copyWith(emailError: "Invalid email format");
      return;
    } else {
      state = state.copyWith(emailError: null);
    }

    // Password validation
    if (password.isEmpty) {
      state = state.copyWith(passwordError: "Password is required");
      return;
    } else {
      state = state.copyWith(passwordError: null);
    }

    // Role validation
    if (role == null) {
      state = state.copyWith(accountError: "Select account type");
      return;
    } else {
      state = state.copyWith(accountError: null);
    }

    state = state.copyWith(isLoadingLogin: true);

    final result = await loginUseCase(
      LoginParams(
        email: email,
        password: password,
        role: role,
      ),
    );

    result.fold(
          (failure) => state = state.copyWith(
        isLoadingLogin: false,
        generalError: failure.message,
      ),
          (user) => state = state.copyWith(
        isLoadingLogin: false,
        isSuccess: true,
        user: user,
      ),
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

  void clearAccountError() =>
      state = state.copyWith(accountError: null);

  /// --- Email Regex ---
  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    return emailRegex.hasMatch(email);
  }
}*/
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/login.dart';
import '../../domain/params/login_params.dart';
import 'auth_state.dart';
import 'auth_providers.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
      (ref) => AuthNotifier(
    ref.read(loginUseCaseProvider),
  ),
);

class AuthNotifier extends StateNotifier<AuthState> {
  final Login loginUseCase;

  AuthNotifier(this.loginUseCase) : super(AuthState.initial());

  /// --- Login Email/Password ---
  Future<void> login({
    required String email,
    required String password,
    required String? role,
  }) async {
    state = state.copyWith(
      isSuccess: false,
      // generalError موجود فقط للباك الحقيقي، Fake حاليا مش محتاجه
      // generalError: null,
    );

    // Email validation
    if (email.isEmpty) {
      state = state.copyWith(emailError: "Email is required");
      return;
    } else if (!_isValidEmail(email)) {
      state = state.copyWith(emailError: "Invalid email format");
      return;
    } else {
      state = state.copyWith(emailError: null);
    }

    // Password validation
    if (password.isEmpty) {
      state = state.copyWith(passwordError: "Password is required");
      return;
    } else {
      state = state.copyWith(passwordError: null);
    }

    // Role validation
    if (role == null) {
      state = state.copyWith(accountError: "Select account type");
      return;
    } else {
      state = state.copyWith(accountError: null);
    }

    state = state.copyWith(isLoadingLogin: true);

    // ===== Fake Data حاليا =====
    await Future.delayed(const Duration(seconds: 1));
    state = state.copyWith(
      isLoadingLogin: false,
      isSuccess: true,
      user: User(
        id: 1,
        name: "Noha Mahmoud",
        email: email,
        role:  _mapRole(role),
      ),
    );

    // ===== الكود الحقيقي للباك لما يجهز =====
    /*
    final result = await loginUseCase(
      LoginParams(
        email: email,
        password: password,
        role: role,
      ),
    );

    result.fold(
      (failure) => state = state.copyWith(
        isLoadingLogin: false,
        generalError: failure.message,
      ),
      (user) => state = state.copyWith(
        isLoadingLogin: false,
        isSuccess: true,
        user: user,
      ),
    );
    */
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
      r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    return emailRegex.hasMatch(email);
  }

  void reset() {
    state = AuthState.initial();
  }

  UserRole _mapRole(String role) {
    switch (role.toLowerCase()) {
      case 'admin':
        return UserRole.admin;
      case 'teacher':
        return UserRole.teacher;
      case 'parent':
        return UserRole.parent;
      default:
        return UserRole.parent;
    }
  }
}