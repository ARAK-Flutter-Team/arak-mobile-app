import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import '../../../../shared/providers/current_user_provider.dart';
import '../../../profile/domain/usecases/get_current_user.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/logout.dart';
import '../../domain/params/login_params.dart';
import 'auth_state.dart';
import 'auth_providers.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final Login loginUseCase;
  final GetCurrentUser getCurrentUserUseCase;
  final Logout logoutUseCase;
  final Ref ref;

  AuthNotifier(
    this.ref,
    this.loginUseCase,
    this.getCurrentUserUseCase,
    this.logoutUseCase,
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
      (user) async {
        if (user.token != null && user.token!.isNotEmpty) {
          await _saveToken(user.token!);
        }

        int? teacherId = await _fetchTeacherId(user.token ?? '');

        if (teacherId != null) {
          ref.read(currentTeacherIdProvider.notifier).state = teacherId;
        }

        final updatedUser = user.copyWith(teacherId: teacherId);

        state = state.copyWith(
          isLoadingLogin: false,
          isSuccess: true,
          user: updatedUser,
        );

        ref.read(currentUserProvider.notifier).state = updatedUser.copyWith(
          subject: user.subject ?? "Mathematics",
        );
      },
    );
  }

  Future<int?> _fetchTeacherId(String token) async {
    try {
      final dio = Dio(BaseOptions(
        baseUrl: "http://192.168.1.11:5000",
        headers: {"Authorization": "Bearer $token"},
      ));

      final response = await dio.get('/api/Teachers/me');
      print(" [TEACHER ID] Response: ${response.data}");

      if (response.statusCode == 200 && response.data['teacherId'] != null) {
        final teacherId = response.data['teacherId'];
        print(" [TEACHER ID] Fetched teacherId: $teacherId");
        return teacherId;
      }
    } catch (e) {
      print(" [TEACHER ID] Failed to fetch: $e");
    }
    return null;
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
    await logoutUseCase();
    ref.read(currentUserProvider.notifier).state = null;
    ref.read(currentTeacherIdProvider.notifier).state = 0;
    state = AuthState.initial();
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+");
    return emailRegex.hasMatch(email);
  }

  void reset() {
    state = AuthState.initial();
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    print(" Token saved to SharedPreferences");
  }
}
