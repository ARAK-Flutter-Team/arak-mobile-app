import '../entities/student_entity.dart';

abstract class EvaluationRepository {
  Future<Student> getStudentData();
}
