import '../entities/user.dart';
import '../params/login_params.dart';
import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(LoginParams params);

  Future<Either<Failure, User>> socialLogin({
    required String idToken,
    required String provider,
  });
}