import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/parent_home_entity.dart';

abstract class ParentHomeRepository {
  Future<Either<Failure, ParentHomeEntity>> getParentHomeData();
}
