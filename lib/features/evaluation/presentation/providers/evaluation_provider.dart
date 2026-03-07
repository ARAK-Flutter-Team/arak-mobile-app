// lib/features/evaluation/presentation/providers/evaluation_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/student_entity.dart';
import '../../domain/repositories/evaluation_repository.dart';
import '../../data/datasources/evaluation_remote_data_source.dart';
import '../../data/repositories/evaluation_repository_impl.dart';

enum DownloadStatus { idle, downloading, success }

final downloadStatusProvider =
    StateProvider<DownloadStatus>((ref) => DownloadStatus.idle);

// 1. نعمل Provider للـ Data Source
final evaluationRemoteDataSourceProvider =
    Provider<EvaluationRemoteDataSource>((ref) {
  return EvaluationRemoteDataSourceImpl();
});

// 2. نعمل Provider للـ Repository
final evaluationRepositoryProvider = Provider<EvaluationRepository>((ref) {
  return EvaluationRepositoryImpl(
    remoteDataSource: ref.watch(evaluationRemoteDataSourceProvider),
  );
});

// 3. نعمل Provider للداتا النهائية
final studentProvider = FutureProvider<Student>((ref) async {
  final repository = ref.watch(evaluationRepositoryProvider);
  return repository.getStudentData();
});
