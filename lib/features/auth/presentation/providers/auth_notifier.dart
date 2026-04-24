/*import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/current_user_provider.dart';
import '../../../profile/domain/usecases/get_current_user.dart';
import '../../domain/usecases/login.dart';
import '../../domain/params/login_params.dart';
import 'auth_state.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final Login loginUseCase;
  final GetCurrentUser getCurrentUserUseCase;
  final Ref ref;

  AuthNotifier(
      this.ref,
      this.loginUseCase,
      this.getCurrentUserUseCase,
      ) : super(AuthState.initial());

  // ===============================
  // Email Validation
  // ===============================
  void validateEmail(String email) {
    if (email.isEmpty) {
      state = state.copyWith(emailError: "Email is required");
      return;
    }

    if (!_isValidEmail(email)) {
      state = state.copyWith(emailError: "Invalid email format");
      return;
    }

    state = state.copyWith(emailError: null);
  }

  // ===============================
  // Password Validation
  // ===============================
  void validatePassword(String password) {
    if (password.isEmpty) {
      state = state.copyWith(passwordError: "Password is required");
      return;
    }

    if (password.length < 6) {
      state = state.copyWith(
        passwordError: "Password must be at least 6 characters",
      );
      return;
    }

    state = state.copyWith(passwordError: null);
  }

  // ===============================
  // Role Validation (UI فقط)
  // ===============================
  void validateRole(String? role) {
    if (role == null) {
      state = state.copyWith(accountError: "Select account type");
      return;
    }

    state = state.copyWith(accountError: null);
  }

  // ===============================
  // LOGIN
  // ===============================
  Future<void> login({
    required String email,
    required String password,
    required String? role,
  }) async {
    // Reset errors
    state = state.copyWith(
      emailError: null,
      passwordError: null,
      accountError: null,
      generalError: null,
      isSuccess: false,
    );

    // Validation
    if (email.isEmpty) {
      state = state.copyWith(emailError: "Email is required");
      return;
    }

    if (!_isValidEmail(email)) {
      state = state.copyWith(emailError: "Invalid email format");
      return;
    }

    if (password.isEmpty) {
      state = state.copyWith(passwordError: "Password is required");
      return;
    }

    if (password.length < 6) {
      state = state.copyWith(
        passwordError: "Password must be at least 6 characters",
      );
      return;
    }

    if (role == null) {
      state = state.copyWith(accountError: "Select account type");
      return;
    }

    // Loading
    state = state.copyWith(isLoadingLogin: true);

    final result = await loginUseCase(
      LoginParams(
        email: email,
        password: password,
      ),
    );

    result.fold(
          (failure) {
        state = state.copyWith(
          isLoadingLogin: false,
          generalError: failure.message,
        );
      },
          (user) {
        // Success
        state = state.copyWith(
          isLoadingLogin: false,
          isSuccess: true,
          user: user,
        );

        // Save globally
        ref.read(currentUserProvider.notifier).state = user.copyWith(
          subject: user.subject ?? "Mathematics",
        );
      },
    );
  }

  // ===============================
  // GET CURRENT USER (Auto Login)
  // ===============================
  Future<void> getCurrentUser() async {
    state = state.copyWith(isLoadingLogin: true);

    final result = await getCurrentUserUseCase();

    result.fold(
          (failure) {
        state = state.copyWith(
          isLoadingLogin: false,
          generalError: failure.message,
        );
      },
          (user) {
        state = state.copyWith(
          isLoadingLogin: false,
          isSuccess: true,
          user: user,
        );

        ref.read(currentUserProvider.notifier).state = user;
      },
    );
  }

  // ===============================
  // LOGOUT
  // ===============================
  Future<void> logout() async {
    // امسح اليوزر من global
    ref.read(currentUserProvider.notifier).state = null;

    // reset state
    state = AuthState.initial();
  }

  // ===============================
  // Email Regex
  // ===============================
  bool _isValidEmail(String email) {
    final emailRegex =
    RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+");
    return emailRegex.hasMatch(email);
  }

  // ===============================
  // RESET
  // ===============================
  void reset() {
    state = AuthState.initial();
  }
}*/
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/current_user_provider.dart';
import '../../../profile/domain/usecases/get_current_user.dart';
import '../../../schedule/presentation/providers/schedule_providers.dart';
import '../../domain/usecases/login.dart';
import '../../domain/params/login_params.dart';
import 'auth_state.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final Login loginUseCase;
  final GetCurrentUser getCurrentUserUseCase;
  final Ref ref;

  AuthNotifier(
      this.ref,
      this.loginUseCase,
      this.getCurrentUserUseCase,
      ) : super(AuthState.initial());

  // ===============================
  // Email Validation
  // ===============================
  void validateEmail(String email) {
    if (email.isEmpty) {
      state = state.copyWith(emailError: "Email is required");
      return;
    }

    if (!_isValidEmail(email)) {
      state = state.copyWith(emailError: "Invalid email format");
      return;
    }

    state = state.copyWith(emailError: null);
  }

  // ===============================
  // Password Validation
  // ===============================
  void validatePassword(String password) {
    if (password.isEmpty) {
      state = state.copyWith(passwordError: "Password is required");
      return;
    }

    if (password.length < 6) {
      state = state.copyWith(
        passwordError: "Password must be at least 6 characters",
      );
      return;
    }

    state = state.copyWith(passwordError: null);
  }

  // ===============================
  // Role Validation (UI فقط)
  // ===============================
  void validateRole(String? role) {
    if (role == null) {
      state = state.copyWith(accountError: "Select account type");
      return;
    }

    state = state.copyWith(accountError: null);
  }

  // ===============================
  // LOGIN
  // ===============================
  Future<void> login({
    required String email,
    required String password,
    required String? role,
  }) async {
    // Reset errors
    state = state.copyWith(
      emailError: null,
      passwordError: null,
      accountError: null,
      generalError: null,
      isSuccess: false,
    );

    // Validation
    if (email.isEmpty) {
      state = state.copyWith(emailError: "Email is required");
      return;
    }

    if (!_isValidEmail(email)) {
      state = state.copyWith(emailError: "Invalid email format");
      return;
    }

    if (password.isEmpty) {
      state = state.copyWith(passwordError: "Password is required");
      return;
    }

    if (password.length < 6) {
      state = state.copyWith(
        passwordError: "Password must be at least 6 characters",
      );
      return;
    }

    if (role == null) {
      state = state.copyWith(accountError: "Select account type");
      return;
    }

    // Loading
    state = state.copyWith(isLoadingLogin: true);

    final result = await loginUseCase(
      LoginParams(
        email: email,
        password: password,
      ),
    );

    result.fold(
          (failure) {
        state = state.copyWith(
          isLoadingLogin: false,
          generalError: failure.message,
        );
      },
          (user) {
        // Success
        state = state.copyWith(
          isLoadingLogin: false,
          isSuccess: true,
          user: user,
        );

        // حفظ التوكن في الـ ApiService
        final apiService = ref.read(apiServiceProvider);
        if (user.token != null && user.token!.isNotEmpty) {
          apiService.updateToken(user.token!);
        }

        // Save globally
        ref.read(currentUserProvider.notifier).state = user.copyWith(
          subject: user.subject ?? "Mathematics",
        );
      },
    );
  }

  // ===============================
  // GET CURRENT USER (Auto Login)
  // ===============================
  Future<void> getCurrentUser() async {
    state = state.copyWith(isLoadingLogin: true);

    final result = await getCurrentUserUseCase();

    result.fold(
          (failure) {
        state = state.copyWith(
          isLoadingLogin: false,
          generalError: failure.message,
        );
      },
          (user) {
        state = state.copyWith(
          isLoadingLogin: false,
          isSuccess: true,
          user: user,
        );

        ref.read(currentUserProvider.notifier).state = user;
      },
    );
  }

  // ===============================
  // LOGOUT
  // ===============================
  Future<void> logout() async {
    // امسح اليوزر من global
    ref.read(currentUserProvider.notifier).state = null;

    // reset state
    state = AuthState.initial();
  }

  // ===============================
  // Email Regex
  // ===============================
  bool _isValidEmail(String email) {
    final emailRegex =
    RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+");
    return emailRegex.hasMatch(email);
  }

  // ===============================
  // RESET
  // ===============================
  void reset() {
    state = AuthState.initial();
  }
}

// ============================================================
/*

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arak_app/core/network/api_service.dart';
import '../../../../shared/providers/current_user_provider.dart';
import '../../../profile/domain/usecases/get_current_user.dart';
import '../../../schedule/presentation/providers/schedule_providers.dart';
import '../../domain/usecases/login.dart';
import '../../domain/params/login_params.dart';
import 'auth_state.dart';

class AuthNotifier_Old extends StateNotifier<AuthState> {
  final Login loginUseCase;
  final GetCurrentUser getCurrentUserUseCase;
  final Ref ref;

  AuthNotifier_Old(
    this.ref,
    this.loginUseCase,
    this.getCurrentUserUseCase,
  ) : super(AuthState.initial());

  void validateEmail(String email) {
    if (email.isEmpty) {
      state = state.copyWith(emailError: "Email is required");
      return;
    }
    if (!_isValidEmail(email)) {
      state = state.copyWith(emailError: "Invalid email format");
      return;
    }
    state = state.copyWith(emailError: null);
  }

  void validatePassword(String password) {
    if (password.isEmpty) {
      state = state.copyWith(passwordError: "Password is required");
      return;
    }
    if (password.length < 6) {
      state = state.copyWith(
        passwordError: "Password must be at least 6 characters",
      );
      return;
    }
    state = state.copyWith(passwordError: null);
  }

  void validateRole(String? role) {
    if (role == null) {
      state = state.copyWith(accountError: "Select account type");
      return;
    }
    state = state.copyWith(accountError: null);
  }

  Future<void> login({
    required String email,
    required String password,
    required String? role,
  }) async {
    state = state.copyWith(
      emailError: null,
      passwordError: null,
      accountError: null,
      generalError: null,
      isSuccess: false,
    );

    if (email.isEmpty) {
      state = state.copyWith(emailError: "Email is required");
      return;
    }
    if (!_isValidEmail(email)) {
      state = state.copyWith(emailError: "Invalid email format");
      return;
    }
    if (password.isEmpty) {
      state = state.copyWith(passwordError: "Password is required");
      return;
    }
    if (password.length < 6) {
      state = state.copyWith(
        passwordError: "Password must be at least 6 characters",
      );
      return;
    }
    if (role == null) {
      state = state.copyWith(accountError: "Select account type");
      return;
    }

    state = state.copyWith(isLoadingLogin: true);

    final result = await loginUseCase(
      LoginParams(email: email, password: password),
    );

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoadingLogin: false,
          generalError: failure.message,
        );
      },
      (user) {
        state = state.copyWith(
          isLoadingLogin: false,
          isSuccess: true,
          user: user,
        );
        ref.read(currentUserProvider.notifier).state = user.copyWith(
          subject: user.subject ?? "Mathematics",
        );
      },
    );
  }

  Future<void> getCurrentUser() async {
    state = state.copyWith(isLoadingLogin: true);
    final result = await getCurrentUserUseCase();
    result.fold(
      (failure) {
        state = state.copyWith(
          isLoadingLogin: false,
          generalError: failure.message,
        );
      },
      (user) {
        state = state.copyWith(
          isLoadingLogin: false,
          isSuccess: true,
          user: user,
        );
        ref.read(currentUserProvider.notifier).state = user;
      },
    );
  }

  Future<void> logout() async {
    ref.read(currentUserProvider.notifier).state = null;
    state = AuthState.initial();
  }

  bool _isValidEmail(String email) {
    final emailRegex =
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+");
    return emailRegex.hasMatch(email);
  }

  void reset() {
    state = AuthState.initial();
  }
}
*/