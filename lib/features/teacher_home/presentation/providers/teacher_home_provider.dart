import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_provider.dart';
import '../../data/datasources/teacher_home_remote_data_source.dart';
import '../../data/repositories/teacher_home_repository_impl.dart';
import '../../domain/repositories/teacher_home_repository.dart';
import '../../domain/usecases/get_teacher_home_data.dart';
import '../../domain/entities/teacher_home_entity.dart';

// Provider لدالة الـ Dio يتم استخدامه من core/network/dio_provider.dart

// Provider لـ Remote Data Source
final teacherHomeRemoteDataSourceProvider =
    Provider<TeacherHomeRemoteDataSource>((ref) {
  final dio = ref.watch(dioProvider);
  return TeacherHomeRemoteDataSourceImpl(dio);
});

// Provider لـ Repository
final teacherHomeRepositoryProvider = Provider<TeacherHomeRepository>((ref) {
  final remoteDataSource = ref.watch(teacherHomeRemoteDataSourceProvider);
  return TeacherHomeRepositoryImpl(remoteDataSource);
});

// Provider لـ Usecase
final getTeacherHomeDataProvider = Provider<GetTeacherHomeData>((ref) {
  final repository = ref.watch(teacherHomeRepositoryProvider);
  return GetTeacherHomeData(repository);
});

// الـ Provider النهائي للشاشة
final teacherHomeProvider = FutureProvider<TeacherHomeEntity>((ref) async {
  final usecase = ref.watch(getTeacherHomeDataProvider);
  final result = await usecase();

  return result.fold(
    (failure) => throw Exception(failure.message),
    (data) => data,
  );
});
