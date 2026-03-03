import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/user.dart';
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
}