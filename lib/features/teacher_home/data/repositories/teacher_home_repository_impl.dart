import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/teacher_home_entity.dart';
import '../../domain/repositories/teacher_home_repository.dart';
import '../datasources/teacher_home_remote_data_source.dart';

class TeacherHomeRepositoryImpl
    implements TeacherHomeRepository {

  final TeacherHomeRemoteDataSource remoteDataSource;

  TeacherHomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, TeacherHomeEntity>> getTeacherHomeData() async {
    try {
      final model = await remoteDataSource.getTeacherHomeData();
      return Right(model.toEntity());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}