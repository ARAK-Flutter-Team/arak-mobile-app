import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arak_app/core/network/dio_provider.dart';
import '../../data/datasources/student_details_remote_data_source.dart';
import '../../data/repositories/student_details_repository_impl.dart';
import '../../domain/entities/student_details_entity.dart';
import '../../domain/usecases/get_student_details_usecase.dart';

// ── DataSource
final _studentDetailsDataSourceProvider =
    Provider<StudentDetailsRemoteDataSource>(
  (ref) => StudentDetailsRemoteDataSourceImpl(ref.watch(dioProvider)),
);

// ── Repository
final _studentDetailsRepositoryProvider =
    Provider<StudentDetailsRepositoryImpl>(
  (ref) => StudentDetailsRepositoryImpl(
    ref.watch(_studentDetailsDataSourceProvider),
  ),
);

// ── UseCase
final _getStudentDetailsUseCaseProvider =
    Provider<GetStudentDetailsUseCase>(
  (ref) => GetStudentDetailsUseCase(
    ref.watch(_studentDetailsRepositoryProvider),
  ),
);

// ── Public FutureProvider — keyed by studentId
final studentDetailsProvider =
    FutureProvider.family<StudentDetailsEntity, String>((ref, studentId) async {
  final usecase = ref.watch(_getStudentDetailsUseCaseProvider);
  final result = await usecase(studentId);
  return result.fold(
    (failure) => throw Exception(failure.message),
    (data) => data,
  );
});
