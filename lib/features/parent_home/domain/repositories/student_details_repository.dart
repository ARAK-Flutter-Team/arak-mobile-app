import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/student_details_entity.dart';

abstract class StudentDetailsRepository {
  Future<Either<Failure, StudentDetailsEntity>> getStudentDetails(
      String studentId);
}
