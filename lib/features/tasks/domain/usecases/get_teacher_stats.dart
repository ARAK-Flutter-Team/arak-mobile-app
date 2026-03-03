import '../repositories/task_repository.dart';

class GetTeacherStats {
  final TaskRepository repository;

  GetTeacherStats(this.repository);

  Future<double> call(String teacherId) {
    return repository.getTeacherCompletedPercentage(teacherId);
  }
}