import 'package:flutter/material.dart';
import '../models/student_model.dart';
// ضفنا الاستيراد ده عشان يتعرف على Subject
import '../../domain/entities/student_entity.dart';

abstract class EvaluationRemoteDataSource {
  Future<StudentModel> getStudentEvaluation();
}

class EvaluationRemoteDataSourceImpl implements EvaluationRemoteDataSource {
  @override
  Future<StudentModel> getStudentEvaluation() async {
    // محاكاة تأخير السيرفر
    await Future.delayed(const Duration(milliseconds: 500));

    // شيلنا كلمة const من هنا عشان مفيش مشاكل
    return StudentModel(
      name: 'Ahmed Abdullah',
      grade: 'Grade 9',
      subjects: [
        Subject(
            name: 'Math',
            score: 92,
            icon: Icons.calculate,
            color: Colors.orange),
        Subject(
            name: 'Science',
            score: 85,
            icon: Icons.science,
            color: Colors.green),
        Subject(
            name: 'English',
            score: 84,
            icon: Icons.book,
            color: Colors.lightBlue),
      ],
    );
  }
}
