/*class Evaluation {
  final int studentId;
  final int classId;
  final int subjectId;
  final String assessmentType;
  final int? marks;
  final int maxMarks;
  final DateTime date;
  final bool isAbsent;

  Evaluation({
    required this.studentId,
    required this.classId,
    required this.subjectId,
    required this.assessmentType,
    required this.marks,
    required this.maxMarks,
    required this.date,
    required this.isAbsent,
  });
}*/
class Evaluation {
  final int studentId;
  final int classId;
  final int subjectId;
  final String assessmentType;
  final int? marks;
  final int maxMarks;
  final DateTime date;
  final bool isAbsent;
  final String? status;

  Evaluation({
    required this.studentId,
    required this.classId,
    required this.subjectId,
    required this.assessmentType,
    required this.marks,
    required this.maxMarks,
    required this.date,
    required this.isAbsent,
    this.status,
  });
}