// lib/features/evaluation/presentation/providers/evaluation_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:arak_app/core/network/dio_provider.dart';
import 'package:arak_app/features/parent_home/presentation/providers/parent_home_provider.dart';
import '../../data/datasources/evaluation_remote_data_source.dart';
import '../../data/repositories/evaluation_repository_impl.dart';
import '../../domain/entities/student_entity.dart';
import '../../domain/repositories/evaluation_repository.dart';

enum DownloadStatus { idle, downloading, success }

final downloadStatusProvider =
    StateProvider<DownloadStatus>((ref) => DownloadStatus.idle);

// ── Providers للـ DataSource → Repository ─────────────────────
final evaluationRemoteDataSourceProvider =
    Provider<EvaluationRemoteDataSource>((ref) {
  return EvaluationRemoteDataSourceImpl(ref.watch(dioProvider));
});

final evaluationRepositoryProvider = Provider<EvaluationRepository>((ref) {
  return EvaluationRepositoryImpl(
    remoteDataSource: ref.watch(evaluationRemoteDataSourceProvider),
  );
});

// ── Provider النهائي ──────────────────────────────────────────
final studentEvaluationProvider = FutureProvider<Student>((ref) async {
  final selectedStudent = ref.watch(selectedStudentProvider);

  if (selectedStudent == null) {
    throw Exception('No student selected');
  }

  final classId = selectedStudent.classNumber;
  final studentName = selectedStudent.name;
  final studentGrade = 'Grade ${selectedStudent.grade}';

  final repository = ref.watch(evaluationRepositoryProvider);

  try {
    final evaluations = await repository.getStudentEvaluations(classId);
    final studentEvaluations = evaluations
        .where((e) => e.studentId == selectedStudent.numericId)
        .toList();

    final subjects = studentEvaluations
        .map((e) => Subject(
              name: e.subjectName,
              score: e.score.toInt(),
              icon: _iconForSubject(e.subjectName),
              color: _colorForSubject(e.subjectName),
            ))
        .toList();

    return Student(
      name: studentName,
      grade: studentGrade,
      subjects: subjects,
    );
  } catch (e) {
    rethrow;
  }
});

// ── Helper — icon بناءً على اسم المادة ────────────────────────
IconData _iconForSubject(String name) {
  final lower = name.toLowerCase();
  if (lower.contains('math')) return Icons.calculate;
  if (lower.contains('science') || lower.contains('bio')) return Icons.science;
  if (lower.contains('english') || lower.contains('arabic')) return Icons.book;
  if (lower.contains('history') || lower.contains('geo')) return Icons.public;
  if (lower.contains('art')) return Icons.palette;
  if (lower.contains('sport') || lower.contains('pe')) return Icons.sports;
  return Icons.school;
}

// ── Helper — لون بناءً على اسم المادة ─────────────────────────
Color _colorForSubject(String name) {
  final lower = name.toLowerCase();
  if (lower.contains('math')) return const Color(0xFFFF9800);
  if (lower.contains('science') || lower.contains('bio'))
    return const Color(0xFF4CAF50);
  if (lower.contains('english')) return const Color(0xFF2196F3);
  if (lower.contains('arabic')) return const Color(0xFF9C27B0);
  if (lower.contains('history')) return const Color(0xFF795548);
  if (lower.contains('art')) return const Color(0xFFE91E63);
  if (lower.contains('sport') || lower.contains('pe'))
    return const Color(0xFF00BCD4);
  return const Color(0xFF607D8B);
}
