import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/student_details_entity.dart';
import '../../domain/repositories/student_details_repository.dart';
import '../datasources/student_details_remote_data_source.dart';

class StudentDetailsRepositoryImpl implements StudentDetailsRepository {
  final StudentDetailsRemoteDataSource remoteDataSource;
  const StudentDetailsRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, StudentDetailsEntity>> getStudentDetails(
      String studentId) async {
    try {
      final result = await remoteDataSource.getStudentDetails(studentId);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
