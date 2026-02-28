/*
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../../../core/network/network_info.dart';
import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/datasources/auth_remote_data_source_impl.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/social_login.dart';

// --- Network Info ---
final networkInfoProvider = Provider<NetworkInfo>((ref) {
  return NetworkInfoImpl(InternetConnectionChecker());
});

// --- Remote Data Source ---
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSourceImpl();
});

// --- Repository ---
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    remoteDataSource: ref.read(authRemoteDataSourceProvider),
    networkInfo: ref.read(networkInfoProvider),
  );
});

// --- UseCase ---
final loginUseCaseProvider = Provider<Login>((ref) {
  return Login(ref.read(authRepositoryProvider));
});
final socialLoginUseCaseProvider = Provider<SocialLogin>((ref) {
  return SocialLogin(ref.read(authRepositoryProvider));
});*/
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../../../core/network/network_info.dart';
import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/datasources/fake_auth_remote_data_source.dart'; // استخدم الفيك حاليا
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/login.dart';

// --- Network Info ---
// Fake حاليا مش محتاجه يتأكد من النت، بس خليها جاهزة للباك
final networkInfoProvider = Provider<NetworkInfo>((ref) {
  return NetworkInfoImpl(InternetConnectionChecker());
});

// --- Remote Data Source ---
// ===== FakeData شغال حاليا =====
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return FakeAuthRemoteDataSource();
  /*
  // ===== الكود الحقيقي للباك لما يجهز =====
  return AuthRemoteDataSourceImpl();
  */
});

// --- Repository ---
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    remoteDataSource: ref.read(authRemoteDataSourceProvider),
    networkInfo: ref.read(networkInfoProvider),
  );
});

// --- UseCase ---
final loginUseCaseProvider = Provider<Login>((ref) {
  return Login(ref.read(authRepositoryProvider));
});