/*import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../data/datasources/evaluation_remote_datasource_impl.dart';
import '../../data/repositories/evaluation_repository_impl.dart';
import '../../domain/usecases/get_students.dart';
import '../../domain/usecases/get_evaluations.dart';
import '../../domain/usecases/save_evaluations.dart';
import '../controllers/evaluation_controller.dart';
import '../state/evaluation_state.dart';

/// HTTP
final httpClientProvider = Provider((ref) => http.Client());

/// DataSource
final evaluationRemoteDataSourceProvider = Provider(
      (ref) => EvaluationRemoteDataSourceImpl(
    client: ref.read(httpClientProvider),
    baseUrl: "https://your-api.com/api",
  ),
);

/// Repository
final evaluationRepositoryProvider = Provider(
      (ref) => EvaluationRepositoryImpl(
    ref.read(evaluationRemoteDataSourceProvider),
  ),
);

/// UseCases
final getStudentsProvider = Provider(
      (ref) => GetStudents(ref.read(evaluationRepositoryProvider)),
);

final getEvaluationsProvider = Provider(
      (ref) => GetEvaluations(ref.read(evaluationRepositoryProvider)),
);

final saveEvaluationsProvider = Provider(
      (ref) => SaveEvaluations(ref.read(evaluationRepositoryProvider)),
);

/// Controller
final evaluationControllerProvider =
StateNotifierProvider<EvaluationController, EvaluationState>(
      (ref) => EvaluationController(
    getStudents: ref.read(getStudentsProvider),
    getEvaluations: ref.read(getEvaluationsProvider),
    saveEvaluations: ref.read(saveEvaluationsProvider),
  ),
);*/
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../data/datasources/evaluation_mock_datasource.dart';
import '../../data/datasources/evaluation_remote_datasource_impl.dart';
import '../../data/datasources/evaluation_remote_datasource.dart';
import '../../data/repositories/evaluation_repository_impl.dart';

import '../../domain/usecases/get_students.dart';
import '../../domain/usecases/get_evaluations.dart';
import '../../domain/usecases/save_evaluations.dart';

import '../controllers/evaluation_controller.dart';
import '../state/evaluation_state.dart';

const bool useMock = true;

/// HTTP Client
final httpClientProvider = Provider<http.Client>((ref) {
  return http.Client();
});

/// DataSource (Mock or API)
final evaluationRemoteDataSourceProvider =
Provider<EvaluationRemoteDataSource>((ref) {
  if (useMock) {
    return EvaluationMockDataSource();
  } else {
    return EvaluationRemoteDataSourceImpl(
      client: ref.read(httpClientProvider),
      baseUrl: "https://your-api.com/api",
    );
  }
});

/// Repository
final evaluationRepositoryProvider = Provider<EvaluationRepositoryImpl>((ref) {
  return EvaluationRepositoryImpl(
    ref.read(evaluationRemoteDataSourceProvider),
  );
});

/// UseCases
final getStudentsProvider = Provider<GetStudents>((ref) {
  return GetStudents(ref.read(evaluationRepositoryProvider));
});

final getEvaluationsProvider = Provider<GetEvaluations>((ref) {
  return GetEvaluations(ref.read(evaluationRepositoryProvider));
});

final saveEvaluationsProvider = Provider<SaveEvaluations>((ref) {
  return SaveEvaluations(ref.read(evaluationRepositoryProvider));
});

/// Controller
final evaluationControllerProvider =
StateNotifierProvider<EvaluationController, EvaluationState>((ref) {
  return EvaluationController(
    getStudents: ref.read(getStudentsProvider),
    getEvaluations: ref.read(getEvaluationsProvider),
    saveEvaluations: ref.read(saveEvaluationsProvider),
  );
});