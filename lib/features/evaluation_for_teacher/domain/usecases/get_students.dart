import '../entities/student.dart';
import '../repositories/evaluation_repository.dart';

class GetStudents {
  final EvaluationRepository repository;

  GetStudents(this.repository);

  Future<List<Student>> call(int classId) {
    return repository.getStudents(classId);
  }
}