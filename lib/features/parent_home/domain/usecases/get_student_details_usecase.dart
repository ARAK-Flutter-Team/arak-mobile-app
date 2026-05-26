import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/student_details_entity.dart';
import '../repositories/student_details_repository.dart';

class GetStudentDetailsUseCase {
  final StudentDetailsRepository repository;
  const GetStudentDetailsUseCase(this.repository);

  Future<Either<Failure, StudentDetailsEntity>> call(String studentId) {
    return repository.getStudentDetails(studentId);
  }
}
