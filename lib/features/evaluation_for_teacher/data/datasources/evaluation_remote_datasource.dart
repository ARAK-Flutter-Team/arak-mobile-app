import '../models/evaluation_model.dart';
import '../models/student_model.dart';

abstract class EvaluationRemoteDataSource {
  Future<List<StudentModel>> getStudents(int classId);

  Future<List<EvaluationModel>> getEvaluations({
    required int classId,
    required int subjectId,
  });

  Future<void> saveEvaluations(List<EvaluationModel> evaluations);
}