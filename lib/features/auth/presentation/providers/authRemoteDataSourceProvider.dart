import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../../profile/domain/usecases/get_current_user.dart';
import '../../data/datasources/fake_auth_remote_data_source.dart';
import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/login.dart';
import '../../../../core/network/network_info.dart';

// --- Network Info ---
final networkInfoProvider = Provider<NetworkInfo>((ref) {
  return NetworkInfoImpl(InternetConnectionChecker());
});

// --- Remote Data Source ---
// دلوقتي بيانات وهمية، لما الباك يبقى جاهز، ترجعي لـ AuthRemoteDataSourceImpl()
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return FakeAuthRemoteDataSource();
});

// --- Repository ---
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    remoteDataSource: ref.read(authRemoteDataSourceProvider),
    networkInfo: ref.read(networkInfoProvider),
  );
});

// --- UseCases ---
final loginUseCaseProvider = Provider<Login>((ref) {
  return Login(ref.read(authRepositoryProvider));
});
final getCurrentUserUseCaseProvider = Provider<GetCurrentUser>((ref) {
  return GetCurrentUser(ref.read(authRepositoryProvider));
});
