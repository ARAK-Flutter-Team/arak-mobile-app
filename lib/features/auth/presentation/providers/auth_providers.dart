/*import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'authRemoteDataSourceProvider.dart';
import 'auth_notifier.dart';
import 'auth_state.dart';

final authProvider =
StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final loginUseCase = ref.read(loginUseCaseProvider);
  final getCurrentUserUseCase = ref.read(getCurrentUserUseCaseProvider);

  return AuthNotifier(
    ref,
    loginUseCase,
    getCurrentUserUseCase,
  );
});*/

/*import 'package:arak_app/features/auth/presentation/providers/authRemoteDataSourceProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_notifier.dart';
import 'auth_state.dart';
import 'auth_providers.dart';

final authProvider =
StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final loginUseCase = ref.read(loginUseCaseProvider);
  final getCurrentUserUseCase = ref.read(getCurrentUserUseCaseProvider);

  return AuthNotifier(
    ref,
    loginUseCase,
    getCurrentUserUseCase,
  );
});*/
/*import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../data/datasources/auth_remote_data_source_impl.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/usecases/login.dart';
import '../../../profile/domain/usecases/get_current_user.dart';

import '../../../../core/network/network_info.dart';

import 'auth_notifier.dart';
import 'auth_state.dart';

/// ===============================
/// DIO
/// ===============================
final dioProvider = Provider((ref) {
  return Dio(); //  بدون baseUrl
});

/// ===============================
/// NETWORK INFO
/// ===============================
final networkInfoProvider = Provider<NetworkInfo>((ref) {
  return NetworkInfoImpl(InternetConnectionChecker());
});

/// ===============================
/// REMOTE DATASOURCE
/// ===============================
final authRemoteDataSourceProvider = Provider((ref) {
  return AuthRemoteDataSourceImpl(
    dio: ref.watch(dioProvider),
  );
});

/// ===============================
/// REPOSITORY
/// ===============================
final authRepositoryProvider = Provider((ref) {
  return AuthRepositoryImpl(
    remoteDataSource: ref.watch(authRemoteDataSourceProvider),
    networkInfo: ref.watch(networkInfoProvider), //  حل المشكلة
  );
});

/// ===============================
/// USE CASES
/// ===============================
final loginUseCaseProvider = Provider((ref) {
  return Login(ref.watch(authRepositoryProvider));
});

final getCurrentUserUseCaseProvider = Provider((ref) {
  return GetCurrentUser(ref.watch(authRepositoryProvider));
});

/// ===============================
/// MAIN AUTH PROVIDER
/// ===============================
final authProvider =
StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(
    ref,
    ref.read(loginUseCaseProvider),
    ref.read(getCurrentUserUseCaseProvider),
  );
});*/
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_notifier.dart';
import 'auth_state.dart';
import 'authRemoteDataSourceProvider.dart';

final authProvider =
StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final loginUseCase = ref.read(loginUseCaseProvider);
  final getCurrentUserUseCase = ref.read(getCurrentUserUseCaseProvider);

  return AuthNotifier(
    ref,
    loginUseCase,
    getCurrentUserUseCase,
  );
});