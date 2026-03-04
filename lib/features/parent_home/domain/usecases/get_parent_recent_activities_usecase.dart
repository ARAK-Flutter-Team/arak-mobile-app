import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../shared/models/activity_model.dart';
import '../repositories/parent_home_repository.dart';
import '../../../../core/usecase/no_params.dart';

class GetParentRecentActivitiesUseCase
    implements UseCase<List<ActivityModel>, NoParams> {
  final ParentHomeRepository repository;
  const GetParentRecentActivitiesUseCase(this.repository);

  @override
  Future<Either<Failure, List<ActivityModel>>> call(NoParams params) {
    return repository.getRecentActivities();
  }
}
