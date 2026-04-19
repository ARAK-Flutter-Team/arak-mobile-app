/*import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter/foundation.dart';

import '../../../profile/domain/usecases/get_current_user.dart';
import '../../data/datasources/fake_auth_remote_data_source.dart';
import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/login.dart';
import '../../../../core/network/network_info.dart';

// =========================
//  Network Info (FIXED)
// =========================
final networkInfoProvider = Provider<NetworkInfo>((ref) {
  if (kIsWeb) {
    return NetworkInfoWeb(); //  Web safe
  } else {
    return NetworkInfoImpl(InternetConnectionChecker()); // ✅ Mobile
  }
});

//  Web Implementation
class NetworkInfoWeb implements NetworkInfo {
  @override
  Future<bool> get isConnected async => true;
}

// =========================
// 🔌 Remote Data Source
// =========================
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return FakeAuthRemoteDataSource();
});

// =========================
//  Repository
// =========================
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    remoteDataSource: ref.read(authRemoteDataSourceProvider),
    networkInfo: ref.read(networkInfoProvider),
  );
});

// =========================
//  UseCases
// =========================
final loginUseCaseProvider = Provider<Login>((ref) {
  return Login(ref.read(authRepositoryProvider));
});

final getCurrentUserUseCaseProvider = Provider<GetCurrentUser>((ref) {
  return GetCurrentUser(ref.read(authRepositoryProvider));
});*/
/*import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../../profile/domain/usecases/get_current_user.dart';
import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/datasources/auth_remote_data_source_impl.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/login.dart';
import '../../../../core/network/network_info.dart';

// =========================
//  Network Info
// =========================
final networkInfoProvider = Provider<NetworkInfo>((ref) {
  if (kIsWeb) {
    return NetworkInfoWeb();
  } else {
    return NetworkInfoImpl(InternetConnectionChecker());
  }
});

// Web Implementation
class NetworkInfoWeb implements NetworkInfo {
  @override
  Future<bool> get isConnected async => true;
}

// =========================
//  Remote Data Source ( الباك الحقيقي)
// =========================
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSourceImpl(
    client: http.Client(),
  );
});

// =========================
//  Repository
// =========================
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    remoteDataSource: ref.read(authRemoteDataSourceProvider),
    networkInfo: ref.read(networkInfoProvider),
  );
});

// =========================
//  UseCases
// =========================
final loginUseCaseProvider = Provider<Login>((ref) {
  return Login(ref.read(authRepositoryProvider));
});

final getCurrentUserUseCaseProvider = Provider<GetCurrentUser>((ref) {
  return GetCurrentUser(ref.read(authRepositoryProvider));
});*/
/*import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

import '../../../../core/network/network_info_impl.dart';
import '../../../profile/domain/usecases/get_current_user.dart';
import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/datasources/auth_remote_data_source_impl.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/login.dart';
import '../../../../core/network/network_info.dart';

import 'auth_notifier.dart';
import 'auth_state.dart';

/// =========================
///  Network Info
/// =========================
final networkInfoProvider = Provider<NetworkInfo>((ref) {
  return NetworkInfoImpl(); // ✅ بدون checker
});

/// =========================
///  DIO
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

/// =========================
///  Remote Data Source
/// =========================
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSourceImpl(
    dio: ref.read(dioProvider),
  );
});

/// =========================
///  Repository
/// =========================
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    remoteDataSource: ref.read(authRemoteDataSourceProvider),
    networkInfo: ref.read(networkInfoProvider),
  );
});

/// =========================
///  UseCases
/// =========================
final loginUseCaseProvider = Provider<Login>((ref) {
  return Login(ref.read(authRepositoryProvider));
});

final getCurrentUserUseCaseProvider = Provider<GetCurrentUser>((ref) {
  return GetCurrentUser(ref.read(authRepositoryProvider));
});

/// =========================
///  MAIN AUTH PROVIDER
/// =========================
final authProvider =
StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(
    ref,
    ref.read(loginUseCaseProvider),
    ref.read(getCurrentUserUseCaseProvider),
  );
});*/
/*import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../core/network/network_info.dart';
import '../../../../core/network/network_info_impl.dart';

import '../../../profile/domain/usecases/get_current_user.dart';
import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/datasources/auth_remote_data_source_impl.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/login.dart';

import 'auth_notifier.dart';
import 'auth_state.dart';

/// =========================
///  Network Info ✅ صح
/// =========================
final networkInfoProvider = Provider<NetworkInfo>((ref) {
  return NetworkInfoImpl(InternetConnectionChecker());
});

/// =========================
///  DIO ✅ صح
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

/// =========================
///  Remote Data Source
/// =========================
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSourceImpl(
    dio: ref.read(dioProvider),
  );
});

/// =========================
///  Repository ✅ مهم
/// =========================
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    remoteDataSource: ref.read(authRemoteDataSourceProvider),
    networkInfo: ref.read(networkInfoProvider),
  );
});

/// =========================
///  UseCases
/// =========================
final loginUseCaseProvider = Provider<Login>((ref) {
  return Login(ref.read(authRepositoryProvider));
});

final getCurrentUserUseCaseProvider = Provider<GetCurrentUser>((ref) {
  return GetCurrentUser(ref.read(authRepositoryProvider));
});

/// =========================
///  MAIN AUTH PROVIDER
/// =========================
final authProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(
    ref,
    ref.read(loginUseCaseProvider),
    ref.read(getCurrentUserUseCaseProvider),
  );
});*/
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

import '../../../profile/domain/usecases/get_current_user.dart';
import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/datasources/auth_remote_data_source_impl.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/login.dart';

/// =========================
/// DIO
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

/// =========================
/// Remote Data Source (BACKEND)
/// =========================
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSourceImpl(
    dio: ref.read(dioProvider),
  );
});

/// =========================
/// Repository
/// =========================
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    remoteDataSource: ref.read(authRemoteDataSourceProvider),
  );
});

/// =========================
/// UseCases
/// =========================
final loginUseCaseProvider = Provider<Login>((ref) {
  return Login(ref.read(authRepositoryProvider));
});

final getCurrentUserUseCaseProvider = Provider<GetCurrentUser>((ref) {
  return GetCurrentUser(ref.read(authRepositoryProvider));
});