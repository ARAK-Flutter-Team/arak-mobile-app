import '../../domain/entities/evaluation.dart';

class EvaluationModel extends Evaluation {
  EvaluationModel({
    required super.studentId,
    required super.classId,
    required super.subjectId,
    required super.assessmentType,
    required super.marks,
    required super.maxMarks,
    required super.date,
    required super.isAbsent,
  });

  factory EvaluationModel.fromJson(Map<String, dynamic> json) {
    return EvaluationModel(
      studentId: json['studentId'],
      classId: json['classId'],
      subjectId: json['subjectId'],
      assessmentType: json['assessmentType'],
      marks: json['marks'],
      maxMarks: json['maxMarks'],
      date: DateTime.parse(json['date']),
      isAbsent: json['isAbsent'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "studentId": studentId,
      "classId": classId,
      "subjectId": subjectId,
      "assessmentType": assessmentType,
      "marks": marks,
      "maxMarks": maxMarks,
      "date": date.toIso8601String(),
      "isAbsent": isAbsent,
    };
  }
}