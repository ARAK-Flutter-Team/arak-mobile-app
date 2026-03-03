import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../shared/models/activity_model.dart';
import '../../domain/entities/parent_home_entity.dart';
import '../../domain/repositories/parent_home_repository.dart';
import "../datasources/parent_home_remote_data_source.dart";

class ParentHomeRepositoryImpl implements ParentHomeRepository {
  final ParentHomeRemoteDataSource remoteDataSource;
  const ParentHomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, ParentHomeEntity>> getParentHomeData() async {
    try {
      final result = await remoteDataSource.getParentHomeData();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<ActivityModel>>> getRecentActivities() async {
    try {
      final result = await remoteDataSource.getRecentActivities();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
