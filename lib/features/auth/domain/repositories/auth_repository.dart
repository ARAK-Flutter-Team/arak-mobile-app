import '../../../../core/entities/user.dart';
import '../params/login_params.dart';
import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(LoginParams params);
  Future<Either<Failure, User>> getCurrentUser();
// TODO: Social login removed as per product decision (Closed system)
/*Future<Either<Failure, User>> socialLogin({
    required String idToken,
    required String provider,
  });*/
}

// ================= Fake Repository =================
class FakeAuthRepository implements AuthRepository {
  @override
  Future<Either<Failure, User>> login(LoginParams params) async {
    // محاكاة بيانات وهمية
    await Future.delayed(Duration(seconds: 1));
    return Right(User(
      id: 1,
      name: "Noha Mahmoud",
      email: params.email,
      role: UserRole.parent,
    ));

    // الباك الحقيقي لما يجهز:
    /*
    return await realAuthRepository.login(params);
    */
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    // محاكاة بيانات وهمية
    await Future.delayed(Duration(seconds: 1));
    return Right(User(
      id: 1,
      name: "Noha Mahmoud",
      email: "noha@example.com",
      role: UserRole.parent,
    ));

    // الباك الحقيقي لما يجهز:
    /*
    return await realAuthRepository.getCurrentUser();
    */
  }
}