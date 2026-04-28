// lib/features/evaluation/data/models/evaluation_model.dart

class EvaluationModel {
  final int id;
  final int studentId;
  final int subjectId;
  final String subjectName; // هنعمله fallback لو مش موجود
  final double score;
  final String assessmentType;

  EvaluationModel({
    required this.id,
    required this.studentId,
    required this.subjectId,
    required this.subjectName,
    required this.score,
    required this.assessmentType,
  });

  factory EvaluationModel.fromJson(Map<String, dynamic> json) {
    return EvaluationModel(
      id: json['id'] ?? 0,
      studentId: json['studentId'] ?? 0,
      subjectId: json['subjectId'] ?? 0,
      subjectName: json['subjectName'] ?? json['subject']?['name'] ?? 'Subject',
      score: (json['score'] ?? json['grade'] ?? 0).toDouble(),
      assessmentType: json['assessmentType'] ?? '',
    );
  }
}
