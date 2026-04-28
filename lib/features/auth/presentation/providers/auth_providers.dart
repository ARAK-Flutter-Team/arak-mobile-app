import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

// 1. استدعاء الـ Notifier و State (من نفس المجلد)
import 'auth_notifier.dart';
import 'auth_state.dart';

// 2. استدعاء الـ Repository و DataSource (من مجلد Data)
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/datasources/auth_remote_data_source_impl.dart';

// 3. استدعاء الـ UseCases (من مجلد Domain)
import '../../domain/usecases/login.dart';
import '../../../profile/domain/usecases/get_current_user.dart';

// =========================
/// DIO PROVIDER
/// =========================
final dioProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(
      baseUrl: "http://192.168.1.9:5000/api",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        "Content-Type": "application/json",
      },
    ),
  );
});

// =========================
/// REMOTE DATA SOURCE
/// =========================
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSourceImpl(
    dio: ref.read(dioProvider),
  );
});

// =========================
/// REPOSITORY
/// =========================
final authRepositoryProvider = Provider((ref) {
  return AuthRepositoryImpl(
    remoteDataSource: ref.read(authRemoteDataSourceProvider),
  );
});

// =========================
/// USE CASES
/// =========================
final loginUseCaseProvider = Provider<Login>((ref) {
  return Login(ref.read(authRepositoryProvider));
});

final getCurrentUserUseCaseProvider = Provider<GetCurrentUser>((ref) {
  return GetCurrentUser(ref.read(authRepositoryProvider));
});

// =========================
/// CURRENT TEACHER ID PROVIDER
/// =========================
final currentTeacherIdProvider = StateProvider<int>((ref) => 0);

// =========================
/// AUTH PROVIDER
/// =========================
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final loginUseCase = ref.read(loginUseCaseProvider);
  final getCurrentUserUseCase = ref.read(getCurrentUserUseCaseProvider);

  return AuthNotifier(
    ref,
    loginUseCase,
    getCurrentUserUseCase,
  );
});