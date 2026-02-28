/*import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';
import '../params/login_params.dart';

class Login {
  final AuthRepository repository;

  Login(this.repository);

  Future<Either<Failure, User>> call(LoginParams params) {
    return repository.login(params);
  }
}*/
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';
import '../params/login_params.dart';

class Login {
  final AuthRepository repository;

  Login(this.repository);

  Future<Either<Failure, User>> call(LoginParams params) async {
    // ======= Fake Data حاليا =======
    await Future.delayed(const Duration(seconds: 1)); // لمحاكاة الـloading
    return Right(User(
      id: 1,
      name: "Noha Mahmoud",
      email: params.email,
      role: UserRole.parent,
    ));

    // ======= الكود الحقيقي للباك لما يجهز =======
    /*
    return await repository.login(params);
    */
  }
}