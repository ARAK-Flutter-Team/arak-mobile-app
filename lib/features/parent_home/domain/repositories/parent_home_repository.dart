import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/parent_home_entity.dart';
import '../../../../shared/models/activity_model.dart';

abstract class ParentHomeRepository {
  Future<Either<Failure, ParentHomeEntity>> getParentHomeData();
  Future<Either<Failure, List<ActivityModel>>> getRecentActivities(); // ✅
}
