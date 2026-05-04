/*import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_notifier.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/models/teacher_home_model.dart';

/// ================= Teacher Profile Model =================
class TeacherProfile {
  final String teacherName;
  final String subjectName;
  final String profileImage;

  TeacherProfile({
    required this.teacherName,
    required this.subjectName,
    required this.profileImage,
  });
}

/// ================= Teacher Profile Provider (Mock) =================
final teacherProfileProvider = Provider<TeacherHomeModel?>((ref) {
  final user = ref.watch(authProvider).user;

  if (user == null) return null;

  return TeacherHomeModel(
    teacherName: user.name, //  الاسم الموحد
    subjectName: "Mathematics",
    performance: 0.85,
    assignedClasses: [],
    hasNewTasks: false,
    hasNewMessages: false,
    todayClassesCount: 0,
    nextClass: null,
    recentActivities: [],
  );
});
  /*
  // ================= Teacher Profile Provider (Real API) =================
  final api = ref.read(apiClientProvider); // API Client
  final response = await api.get('/teacher/profile');

  return TeacherProfile(
    teacherName: response.data['teacherName'],
    subjectName: response.data['subjectName'],
    profileImage: response.data['profileImage'],
  );
  */

/// ================= Teacher Performance Provider (Mock) =================
final teacherPerformanceProvider = FutureProvider<double>((ref) async {
  await Future.delayed(const Duration(milliseconds: 400));
  return 82.0;

});*/
// lib/features/teacher_home/presentation/providers/teacher_home_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../../../../core/network/dio_provider.dart';
import '../../data/datasources/teacher_home_remote_data_source.dart';
import '../../data/repositories/teacher_home_repository_impl.dart';
import '../../domain/repositories/teacher_home_repository.dart';
import '../../domain/usecases/get_teacher_home_data.dart';
import '../../domain/entities/teacher_home_entity.dart';

// Provider لدالة الـ Dio يتم استخدامه من core/network/dio_provider.dart


// Provider لـ Remote Data Source
final teacherHomeRemoteDataSourceProvider = Provider<TeacherHomeRemoteDataSource>((ref) {
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