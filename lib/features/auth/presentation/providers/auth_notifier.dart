/*import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/entities/user.dart';
import 'auth_state.dart';

final authProvider =
StateNotifierProvider<AuthNotifier, AuthState>(
      (ref) => AuthNotifier(),
);

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState.initial());

  // ================= LOGIN =================

  Future<void> login({
    required String email,
    required String password,
    required String? role,
  }) async {
    // 🧹 امسحي أي أخطاء قديمة
    state = state.copyWith(
      emailError: null,
      passwordError: null,
      accountError: null,
    );

    // 1️⃣ Email
    if (email.isEmpty) {
      state = state.copyWith(emailError: "Email is required");
      return;
    }

    if (!_isValidEmail(email)) {
      state = state.copyWith(emailError: "Invalid email format");
      return;
    }

    // 2️⃣ Password
    if (password.isEmpty) {
      state = state.copyWith(passwordError: "Password is required");
      return;
    }

    // 3️⃣ Role
    if (role == null) {
      state = state.copyWith(accountError: "Select account type");
      return;
    }

    // 🚀 لو كله تمام
    state = state.copyWith(isLoadingLogin: true);

    await Future.delayed(const Duration(seconds: 1));

    state = state.copyWith(
      isLoadingLogin: false,
      isSuccess: true,
      user: User(
        id: 1,
        name: "Noha Mahmoud",
        email: email,
        role: _mapRole(role),
        classes: _mapRole(role) == UserRole.teacher
            ? ["Class A", "Class B", "Class C"]
            : [],
      ),
    );
  }

  // ================= LIVE VALIDATION =================

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

  void validateRole(String? role) {
    if (role == null) {
      state = state.copyWith(accountError: "Select account type");
    } else {
      state = state.copyWith(accountError: null);
    }
  }

  // ================= HELPERS =================

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+",
    );
    return emailRegex.hasMatch(email);
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

  void reset() {
    state = AuthState.initial();
  }
}*/
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  // Role Validation
  // ===============================
  void validateRole(String? role) {
    if (role == null) {
      state = state.copyWith(accountError: "Select account type");
      return;
    }

    state = state.copyWith(accountError: null);
  }

  // ===============================
  // Login
  // ===============================
  Future<void> login({
    required String email,
    required String password,
    required String? role,
  }) async {

    // امسحي الأخطاء القديمة
    state = state.copyWith(
      emailError: null,
      passwordError: null,
      accountError: null,
      generalError: null,
    );

    // 1️⃣ Email validation
    if (email.isEmpty) {
      state = state.copyWith(emailError: "Email is required");
      return;
    }

    if (!_isValidEmail(email)) {
      state = state.copyWith(emailError: "Invalid email format");
      return;
    }

    // 2️⃣ Password validation
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

    // 3️⃣ Role validation
    if (role == null) {
      state = state.copyWith(accountError: "Select account type");
      return;
    }

    // لو كله تمام
    state = state.copyWith(isLoadingLogin: true);

    final result = await loginUseCase(
      LoginParams(
        email: email,
        password: password,
        role: role,
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
        state = state.copyWith(
          isLoadingLogin: false,
          isSuccess: true,
          user: user,
        );

        ref.read(currentUserProvider.notifier).state = user.copyWith(
          subject: user.subject ?? "Mathematics", // ممكن تجيبي المادة حسب المستخدم
        );
        },
    );
  }

  // ===============================
  // Get Current User
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
          user: user,
        );

        ref.read(currentUserProvider.notifier).state = user;
      },
    );
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