import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/teacher_home_remote_data_source.dart';
import '../../data/datasources/teacher_home_mock_data_source.dart';
import '../../data/repositories/teacher_home_repository_impl.dart';

import '../../domain/repositories/teacher_home_repository.dart';
import '../../domain/usecases/get_teacher_home_data.dart';
import '../../domain/entities/teacher_home_entity.dart';

/// 1️⃣ DataSource Provider
final teacherHomeDataSourceProvider =
Provider<TeacherHomeRemoteDataSource>((ref) {

  // 🔁 حالياً بنستخدم Mock
  return TeacherHomeMockDataSource();

  // ✅ لما الباك يجهز:
  // final dio = ref.read(dioProvider);
  // return TeacherHomeRemoteDataSourceImpl(dio);
});


/// 2️⃣ Repository Provider
final teacherHomeRepositoryProvider =
Provider<TeacherHomeRepository>((ref) {
  return TeacherHomeRepositoryImpl(
    ref.read(teacherHomeDataSourceProvider),
  );
});


/// 3️⃣ UseCase Provider
final getTeacherHomeDataProvider =
Provider<GetTeacherHomeData>((ref) {
  return GetTeacherHomeData(
    ref.read(teacherHomeRepositoryProvider),
  );
});


/// 4️⃣ FutureProvider للشاشة
final teacherHomeProvider =
FutureProvider<TeacherHomeEntity>((ref) async {

  final useCase = ref.watch(getTeacherHomeDataProvider);
  final result = await useCase();

  return result.fold(
        (failure) => throw Exception(failure.message),
        (data) => data,
  );
});