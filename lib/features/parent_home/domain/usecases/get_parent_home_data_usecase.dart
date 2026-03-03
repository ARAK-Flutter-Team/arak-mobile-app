import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/parent_home_entity.dart';
import '../repositories/parent_home_repository.dart';
import '../../../../core/usecase/no_params.dart';

class GetParentHomeDataUseCase implements UseCase<ParentHomeEntity, NoParams> {
  final ParentHomeRepository repository;
  const GetParentHomeDataUseCase(this.repository);

  @override
  Future<Either<Failure, ParentHomeEntity>> call(NoParams params) {
    return repository.getParentHomeData();
  }
}
