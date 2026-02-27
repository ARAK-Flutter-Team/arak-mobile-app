import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';
import '../params/social_login_params.dart'; // 👈 ضيفي ده

class SocialLogin extends UseCase<User, SocialLoginParams> {
  final AuthRepository repository;

  SocialLogin(this.repository);

  @override
  Future<Either<Failure, User>> call(SocialLoginParams params) async {
    return await repository.socialLogin(
      idToken: params.idToken,
      provider: params.provider,
    );
  }
}