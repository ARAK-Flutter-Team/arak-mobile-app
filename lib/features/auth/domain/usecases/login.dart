import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/entities/user.dart';
import '../repositories/auth_repository.dart';
import '../params/login_params.dart';


class Login {
  final AuthRepository repository;

  Login(this.repository);

  Future<Either<Failure, User>> call(LoginParams params) async {
    return await repository.login(params);
  }
}