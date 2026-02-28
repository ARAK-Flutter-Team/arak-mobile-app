/*import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/params/login_params.dart';
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

  @override
  Future<Either<Failure, User>> socialLogin({
    required String idToken,
    required String provider,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final userModel = await remoteDataSource.socialLogin(
          idToken: idToken,
          provider: provider,
        );

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
}*/
import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/params/login_params.dart';
import '../datasources/auth_remote_data_source.dart';
import '../datasources/fake_auth_remote_data_source.dart'; // استخدم الفيك داتا دلوقتي

class AuthRepositoryImpl implements AuthRepository {
  // لو عايزة تشغلي على الباك بعدين، استبدلي FakeAuthRemoteDataSource ب AuthRemoteDataSourceImpl
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, User>> login(LoginParams params) async {
    // لو عايزة تجرب على الفيك داتا دلوقتي
    try {
      final userModel = await remoteDataSource.login(params);
      return Right(userModel);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    } catch (e) {
      return Left(ServerFailure("Unexpected error: $e"));
    }

    /* --- الكود الحقيقي للباك ---
    if (await networkInfo.isConnected) {
      try {
        final userModel = await remoteDataSource.login(params);
        return Right(userModel);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.toString()));
      } catch (e) {
        return Left(ServerFailure("Unexpected error: $e"));
      }
    } else {
      return const Left(NetworkFailure("No Internet Connection"));
    }
    */
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    // الفيك داتا دلوقتي
    try {
      final userModel = await remoteDataSource.getCurrentUser();
      return Right(userModel);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    } catch (e) {
      return Left(ServerFailure("Unexpected error: $e"));
    }

    /* --- الكود الحقيقي للباك ---
    if (await networkInfo.isConnected) {
      try {
        final userModel = await remoteDataSource.getCurrentUser();
        return Right(userModel);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.toString()));
      } catch (e) {
        return Left(ServerFailure("Unexpected error: $e"));
      }
    } else {
      return const Left(NetworkFailure("No Internet Connection"));
    }
    */
  }

// TODO: Social login removed as per product decision (Closed system)
/*
  @override
  Future<Either<Failure, User>> socialLogin({
    required String idToken,
    required String provider,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final userModel = await remoteDataSource.socialLogin(
          idToken: idToken,
          provider: provider,
        );

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
  */
}