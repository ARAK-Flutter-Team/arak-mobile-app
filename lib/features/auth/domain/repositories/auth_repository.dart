import '../entities/user.dart';
import '../usecases/login_params.dart';
import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(LoginParams params);
}