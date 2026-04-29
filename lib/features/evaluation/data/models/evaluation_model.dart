// lib/features/evaluation/data/models/evaluation_model.dart

class EvaluationModel {
  final int id;
  final int studentId;
  final int subjectId;
  final String subjectName;
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
    final marks = (json['marks'] ?? 0).toDouble();
    final maxMarks = (json['maxMarks'] ?? 0).toDouble();
    final score = maxMarks > 0 ? (marks / maxMarks * 100) : 0.0;

    return EvaluationModel(
      id: json['id'] ?? 0,
      studentId: json['studentId'] ?? 0,
      subjectId: json['subjectId'] ?? 0,
      subjectName: json['subjectName'] ??
          json['subject']?['name'] ??
          _subjectNameFromId(json['subjectId']),
      score: score,
      assessmentType: json['assessmentType'] ?? '',
    );
  }

  static String _subjectNameFromId(dynamic id) {
    const map = {
      7: 'Math',
      8: 'Science',
      9: 'English',
      10: 'Arabic',
      11: 'History',
      12: 'Art',
    };
    return map[id] ?? 'Subject';
  }
}
