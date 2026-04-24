import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arak_app/core/network/api_service.dart';
// ⚠️ تم حذف Import الطالب الموجود هنا بالأعلى
import '../../data/datasources/schedule_remote_data_source.dart';
import '../../data/repositories/schedule_repository_impl.dart';
import '../../domain/usecases/get_teacher_schedule.dart';
// استدعاء Notifier المعلم
import 'schedule_notifier.dart';
// استدعاء State المعلم
import 'schedule_state.dart';

// 1. ApiService Provider
final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

// 2. Remote DataSource
final scheduleRemoteDataSourceProvider =
Provider<ScheduleRemoteDataSource>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return ScheduleRemoteDataSourceImpl(apiService);
});

// 3. Repository
final scheduleRepositoryProvider = Provider((ref) {
  final remote = ref.watch(scheduleRemoteDataSourceProvider);
  return ScheduleRepositoryImpl(remote);
});

// 4. UseCase
final getTeacherScheduleProvider = Provider((ref) {
  final repo = ref.watch(scheduleRepositoryProvider);
  return GetTeacherSchedule(repo);
});

// 5. Notifier (المسؤول عن الـ State Management)
final teacherScheduleNotifierProvider =
StateNotifierProvider<ScheduleNotifier, ScheduleState>((ref) {
  // جلب الـ UseCase وتمريره للـ Notifier
  final useCase = ref.watch(getTeacherScheduleProvider);
  return ScheduleNotifier(useCase);
});