import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/login_params.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, User>> login(LoginParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final userModel = await remoteDataSource.login(params);
        // تحويل UserModel لـ User (لو مش بالفعل يرث User)
        return Right(userModel);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.toString()));
      } catch (e) {
        return Left(ServerFailure("Unexpected error: $e"));
      }
    } else {
      return const Left(NetworkFailure("No Internet Connection"));
    }
  }
}